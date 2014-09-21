# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'schlepp/version'

Gem::Specification.new do |spec|
  spec.name          = "schlepp"
  spec.version       = Schlepp::VERSION
  spec.authors       = ["Ed Carrel"]
  spec.email         = ["edward@carrel.org"]
  spec.summary       = %q{An extensible chunking file transferer}
  spec.description   = %q{An extensible chunking file transferer}
  spec.homepage      = "https://github.com/azanar/schlepp"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'activesupport', '~> 0'
  spec.add_runtime_dependency 'hydrogen', '~> 0'

  spec.add_development_dependency 'test-unit', '~> 0'
  spec.add_development_dependency 'mocha', '~> 0'
  spec.add_development_dependency 'simplecov', '~> 0'
  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake", "~> 10.0"
end
