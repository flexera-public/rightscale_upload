# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rightscale_upload/version'

Gem::Specification.new do |spec|
  spec.name          = "rightscale_upload"
  spec.version       = RightscaleUpload::VERSION
  spec.authors       = ["Douglas Thrift"]
  spec.email         = ["douglas.thrift@rightscale.com"]
  spec.description   = %q{Upload things like cookbooks to use with RightScale}
  spec.summary       = spec.description
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  # Restrict berkshelf to 2.0.x since the Berkshelf API changes in v3.x
  # breaks rightscale_upload. We should port rightscale_upload to
  # use v3.x berkshelf.
  spec.add_dependency "berkshelf", "~> 2.0.16"
  spec.add_dependency "buff-config"
  spec.add_dependency "chef", ">= 0.10.10"
  spec.add_dependency "fog"
  spec.add_dependency "minitar"
  spec.add_dependency "ridley"
  spec.add_dependency "thor"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
