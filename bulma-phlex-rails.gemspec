# frozen_string_literal: true

require_relative "lib/bulma_phlex/rails/version"

Gem::Specification.new do |spec|
  spec.name = "bulma-phlex-rails"
  spec.version = BulmaPhlex::Rails::VERSION
  spec.authors = ["Todd Kummer"]
  spec.email = ["todd@rockridgesolutions.com"]

  spec.summary = "Bulma-friendly form builder built with Phlex for Rails applications."
  spec.description = "Create forms with Bulma CSS framework styles using Phlex components in your Rails applications."
  spec.homepage = "https://github.com/RockSolt/bulma-phlex-rails"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.4"

  spec.metadata["rubygems_mfa_required"] = "true"
  spec.metadata["homepage_uri"] = spec.homepage

  spec.files = Dir["lib/**/*", "app/**/*", "config/importmap.rb"]

  spec.add_dependency "actionpack", ">= 7.2"
  spec.add_dependency "bulma-phlex", ">= 0.8.0" # switches namespace to BulmaPhlex
  spec.add_dependency "phlex-rails", ">= 2.3"
  spec.add_dependency "railties", ">= 7.2"
end
