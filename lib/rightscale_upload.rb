require "rightscale_upload/version"
require "rightscale_upload/berkshelf"

require "thor"

module RightScaleUpload
  class CLI < Thor
    namespace "rightscale"

    register Berkshelf, "berkshelf", "berkshelf [subcommand]", "Provides berkshelf functionality"
  end
end
