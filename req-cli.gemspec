# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = 'req-cli'
  s.version     = '0.0.1'
  s.date        = '2016-08-13'

  s.summary     = "CLI tool for templating HTTP requests from a config file and execute them with curl."
  s.description = ""
  s.authors     = ["Steven Van Bael"]
  s.email       = 'steven@quantus.io'
  s.homepage    = 'http://github.com/vbsteven/req'
  s.license     = 'MIT'

  s.files       = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^spec/}) }
  s.bindir      = 'bin'
  s.executables = s.files.grep(%r{^bin/}) { |f| File.basename(f) }
  s.require_paths = ['lib']

  s.add_runtime_dependency "thor", "~> 0.19"
  s.add_runtime_dependency "httparty", "~> 0.14"

  s.add_development_dependency 'rspec', '~> 3.5.0'
  s.add_development_dependency 'rake', '~> 11.2.2'
  s.add_development_dependency 'bundler'
end
