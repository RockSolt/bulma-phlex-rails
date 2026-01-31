# frozen_string_literal: true

require "action_view"
require "bulma-phlex"
require "phlex-rails"
require "zeitwerk"

module BulmaPhlex
  # The Rails namespace provides Bulma Phlex components and helpers for integration with Ruby on Rails applications.
  module Rails
  end
end

loader = Zeitwerk::Loader.for_gem_extension(BulmaPhlex)
loader.collapse("#{__dir__}/rails/components")
loader.collapse("#{__dir__}/rails/components/displays")
loader.collapse("#{__dir__}/rails/concerns")
loader.collapse("#{__dir__}/rails/helpers")
loader.setup

require "bulma_phlex/rails/engine"

# Rails-specific extensions to BulmaPhlex components
BulmaPhlex::Card.include(BulmaPhlex::Rails::CardHelper) if defined?(Turbo)
BulmaPhlex::Table.include(BulmaPhlex::Rails::TableHelper)
