require "rightscale_upload/config"

require "archive/tar/minitar"
require "berkshelf"
require "chef/cookbook_loader"
require "chef/knife/cookbook_metadata"
require "fog"
require "pathname"
require "ridley"
require "tempfile"
require "thor"
require "tmpdir"
require "zlib"

module RightScaleUpload
  class Berkshelf < Thor
    namespace "rightscale:berkshelf"

    method_option :berksfile,
      type: :string,
      default: ::Berkshelf::DEFAULT_FILENAME,
      desc: "Path to a Berksfile to operate off of.",
      aliases: '-b',
      banner: 'PATH'
    method_option :environment,
      type: :string,
      default: 'dev',
      desc: 'The environment where the cookbook collection will be used. Example: dev, stage, prod.',
      aliases: '-e',
      banner: 'ENVIRONMENT'
    method_option :force,
      type: :boolean,
      default: false,
      desc: "Force upload even if a file already exists.",
      aliases: '-f'
    desc "upload", "Upload cookbooks from berkshelf for use with RightScale"
    def upload
      cd_root(options[:berksfile])

      config = Config.from_file(File.expand_path("~/.rightscale_upload.json"))
      metadata = Ridley::Chef::Cookbook::Metadata.from_file('metadata.rb')
      upload_path = "#{metadata.name}/#{options[:environment]}/#{metadata.version}.tar.gz"
      storage = Fog::Storage.new(config.fog)
      container = storage.directories.get(config.container)

      if !options[:force] && container.files.get(upload_path)
        raise "#{upload_path} already exists in #{config.container}"
      end

      Dir.mktmpdir(["rightscale-", "-berkshelf"]) do |path|
        berksfile = ::Berkshelf::Berksfile.from_file(options[:berksfile])
        berksfile.install(options.merge(path: path))

        cookbook_metadata = Chef::Knife::CookbookMetadata.new
        cookbook_metadata.config[:all] = true
        cookbook_metadata.config[:cookbook_path] = path
        cookbook_metadata.run

        Tempfile.open(["rightscale-", "-berkshelf.tar.gz"]) do |file|
          Zlib::GzipWriter.open(file) do |tgz|
            Dir.chdir(path) do
              Archive::Tar::Minitar.pack('.', tgz)
            end
          end

          upload = container.files.create(key: upload_path, body: file, public: true)
          upload.save

          puts "Uploaded to: #{upload.public_url}"
        end
      end
    rescue Exception => e
      STDERR.puts "#{File.basename($PROGRAM_NAME)}: #{e}"
      exit 1
    end

    private

    def cd_root(berksfile)
      path = Pathname.getwd
      until path.join(berksfile).exist?
        path = path.dirname
        raise "did not find #{berksfile}" if path.root?
      end
      Dir.chdir(path)
    end
  end
end
