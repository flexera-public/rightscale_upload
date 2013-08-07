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

  spec.add_dependency "berkshelf"
  spec.add_dependency "buff-config"
  spec.add_dependency "chef", ">= 0.10.10"
  spec.add_dependency "fog"
  spec.add_dependency "minitar"
  spec.add_dependency "ridley"
  spec.add_dependency "thor"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
