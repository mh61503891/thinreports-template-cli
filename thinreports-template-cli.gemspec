# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thinreports/template/cli/version'

Gem::Specification.new do |spec|
  spec.name          = 'thinreports-template-cli'
  spec.version       = Thinreports::Template::CLI::VERSION
  spec.authors       = ['mh61503891']
  spec.email         = ['msyk@hgsn.info']

  spec.summary       = %q{A command line tool to generate a PDF file from YAML config file and .tlf}
  spec.description   = %q{A command line tool to generate a PDF file from YAML config file and .tlf}
  spec.homepage      = 'https://github.com/mh61503891/thinreports-template-cli'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'thinreports', '0.9.1'
  spec.add_dependency 'thor', '0.19.1'
  spec.add_dependency 'wareki', '0.1.2'
  spec.add_dependency 'kosi', '1.0.0'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'awesome_print', '~> 1.7.0'
  spec.add_development_dependency 'pry', '~> 0.10.4'
end
