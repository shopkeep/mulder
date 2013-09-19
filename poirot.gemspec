# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'poirot/version'

Gem::Specification.new do |spec|
  spec.name          = 'poirot'
  spec.version       = Poirot::VERSION
  spec.authors       = ['Duncan Grazier']
  spec.email         = ['itsmeduncan@gmail.com']
  spec.description   = %q{Discover information about AWS Autoscaling Groups}
  spec.summary       = %q{Autoscaling groups, and their metadata}
  spec.homepage      = 'https://www.github.com/shopkeep/poirot'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.3'
  spec.add_development_dependency 'mocha', '~> 0.14.0'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec', '~> 2.14.1'
  spec.add_development_dependency 'simplecov', '~> 0.7.1'

  spec.add_dependency 'fog', '~> 1.15.0'
  spec.add_dependency 'isomer', '~> 0.1.3'
  spec.add_dependency 'thor', '~> 0.18.1'
end
