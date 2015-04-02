Gem::Specification.new do |s|
  s.name        = 'transmission-rpc-ruby'
  s.version     = '0.3.0'
  s.date        = '2015-04-02'
  s.summary     = "Transmission RPC wrapper in Ruby"
  s.description = "A new transmission RPC wrapper for Ruby. All object oriented for controlling remote transmission daemons."
  s.authors     = ["Max Hoffmann"]
  s.email       = 'tsov@me.com'
  s.files       = `git ls-files`.split($/)
  s.homepage    = 'https://github.com/transmission-rails/transmission-rpc-ruby'
  s.license     = 'MIT'
  s.require_paths = ["lib"]
  s.add_dependency "faraday", "~> 0.9"
  s.add_development_dependency "rake", "~> 10.4"
  s.add_development_dependency "rspec", "~> 3.2"
  s.add_development_dependency "webmock", "~> 1.21"
end