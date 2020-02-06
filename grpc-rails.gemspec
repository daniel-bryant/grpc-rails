$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "grpc/rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "grpc-rails"
  spec.version     = GRPC::Rails::VERSION
  spec.authors     = ["daniel-bryant"]
  spec.email       = ["bryant.daniel.j@gmail.com"]
  spec.homepage    = "https://github.com/daniel-bryant/grpc_rails"
  spec.summary     = "Ruby on Rails plugin for gRPC support."
  spec.description = "Ruby on Rails plugin for gRPC support."
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.2", ">= 6.0.2.1"
  spec.add_dependency "grpc", "~> 1.26"
  spec.add_dependency "thor", "~> 1.0"

  spec.add_development_dependency "aruba"
  spec.add_development_dependency "cucumber"
  spec.add_development_dependency "sqlite3"
end
