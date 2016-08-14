Gem::Specification.new do |s|
  s.name        = 'req-cli'
  s.version     = '0.0.1'
  s.date        = '2016-08-13'
  s.summary     = "CLI tool for templating HTTP requests from a config file and execute them with curl.
"
  s.description = ""
  s.authors     = ["Steven Van Bael"]
  s.email       = 'steven@quantus.io'
  s.files       = Dir['lib/**/*.rb']
  s.homepage    =
    'http://github.com/vbsteven/req'
  s.license       = 'MIT'

  s.executables << 'req'

  s.add_runtime_dependency "thor", "~> 0.19"
  s.add_runtime_dependency "httparty", "~> 0.14"
end
