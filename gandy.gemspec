# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'gandy/version'

Gem::Specification.new do |spec|
  spec.name          = 'gandy'
  spec.version       = Gandy::VERSION
  spec.authors       = ['Brad Fults']
  spec.email         = ['bfults@gmail.com']
  spec.summary       = %q{Maintaining your Rails and keeping everything running smoothly.}
  spec.description   = %q{Allows you to specify checks and tasks to autorun that keep your Rails development environment up to date and ready to use.}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_dependency 'colorize', '~> 0.6'

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
end
