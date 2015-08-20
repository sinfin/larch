$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "larch/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "larch"
  s.version     = Larch::VERSION
  s.authors     = ["Jakub Hozak"]
  s.email       = ["jakub.hozak@gmail.com"]
  s.homepage    = "http://github.com/sinfin/larch"
  s.summary     = "Ember.js tree component and its Rails server side."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.2"

  s.add_dependency "active_model_serializers"
  s.add_dependency "barber"
  # BEWARE: higher versions of ember-rails may break Emblem compilation
  s.add_dependency "ember-rails",'0.16.2'
  s.add_dependency "emblem-rails"
  s.add_dependency "jquery-cookie-rails"

  s.add_development_dependency "sqlite3"
end
