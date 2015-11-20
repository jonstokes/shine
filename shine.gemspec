$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "shine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "shine"
  s.version     = Shine::VERSION
  s.authors     = ["Jon Stokes"]
  s.email       = ["jon@jonstokes.com"]
  s.homepage    = "http://github.com/jonstokes/shine.git"
  s.summary     = "A blog engine for rails that uses contentful."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.5"
  s.add_dependency "pg"
  s.add_dependency "figaro"
  s.add_dependency "troupe"
  s.add_dependency "rest-client"
  s.add_dependency "kramdown"
end
