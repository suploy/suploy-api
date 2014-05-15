# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'suploy/api/version'

Gem::Specification.new do |spec|
  spec.name          = "suploy-api"
  spec.version       = Suploy::Api::VERSION
  spec.authors       = ["flower-pot"]
  spec.email         = ["fbranczyk@gmail.com"]
  spec.summary       = "Ruby API for suploy"
  spec.description   = "Use the suploy API with the beauty of ruby."
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency "excon"
  spec.add_runtime_dependency "json"
end
