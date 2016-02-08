# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hephaistos/version'

Gem::Specification.new do |spec|
  spec.name          = "hephaistos"
  spec.version       = Hephaistos::VERSION
  spec.authors       = ["Vinh Nguyen"]
  spec.email         = ["vinh.nglx@gmail.com"]

  spec.summary       = %q{Hephaistos - Simple search CLI tool.}
  spec.description   = %q{Search everything from StackOverFlow, Rubygems.}
  spec.homepage      = "TODO: Put your gem's website or public repo URL here."
  spec.license       = "MIT"

  spec.files         = Dir['lib/**/*.rb'] + Dir['bin/*']
  spec.executables   = 'hephaistos'
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency 'bundler'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'

  # Add runtime dependencies
  spec.add_dependency 'thor'
  spec.add_dependency 'httparty'
end
