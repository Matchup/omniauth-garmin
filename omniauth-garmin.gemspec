# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'omniauth-garmin/version'

Gem::Specification.new do |spec|
  spec.name          = "omniauth-garmin"
  spec.version       = OmniAuth::Garmin::VERSION
  spec.authors       = ["John Contreras"]
  spec.email         = ["contrerasnet@gmail.com"]
  spec.summary       = %q{an omniauth strategy for garmin.}
  spec.description   = %q{an omniauth strategy for garmin connect api.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"

  spec.add_runtime_dependency 'omniauth-oauth', '~> 1.0'
end
