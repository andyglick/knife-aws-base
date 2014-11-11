# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'knife-aws-base/version'

Gem::Specification.new do |spec|
  spec.name          = "knife-aws-base"
  spec.version       = Knife::AwsBase::VERSION
  spec.authors       = ["Brett Cave"]
  spec.email         = ["brett@cave.za.net"]
  spec.summary       = %q{Common library for Knife AWS plugins}
  spec.description   = spec.summary
  spec.homepage      = "https://github.com/brettcave/knife-aws-base"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler",        "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "mixlib-config",  "~> 2.0"
  spec.add_development_dependency "chef",           ">= 11.16.2"

  spec.add_dependency "fog",            "~> 1.23.0"

end
