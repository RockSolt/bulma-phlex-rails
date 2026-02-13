# frozen_string_literal: true

require_relative "lib/bulma_phlex/rails/version"

Gem::Specification.new do |spec|
  spec.name = "bulma-phlex-rails"
  spec.version = BulmaPhlex::Rails::VERSION
  spec.authors = ["Todd Kummer"]
  spec.email = ["todd@rockridgesolutions.com"]

  spec.summary = <<~SUMMARY
    Simplify the view layer with a component library built on Phlex and styled with Bulma CSS framework. The code is simple and the UI is clean.
  SUMMARY
  spec.homepage = "https://github.com/RockSolt/bulma-phlex-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir["lib/**/*", "app/**/*", "config/importmap.rb"]

  spec.add_dependency "actionpack", ">= 7.2"
  spec.add_dependency "bulma-phlex", ">= 0.11.0"
  spec.add_dependency "phlex-rails", ">= 2.3"
  spec.add_dependency "railties", ">= 7.2"
end
