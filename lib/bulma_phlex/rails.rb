# frozen_string_literal: true

require "action_view"
require "bulma-phlex"
require "phlex-rails"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem_extension(BulmaPhlex)
loader.collapse("#{__dir__}/rails/components")
loader.setup

module BulmaPhlex
  # The Rails namespace provides Bulma Phlex components and helpers for integration with Ruby on Rails applications.
  module Rails
    # Your code goes here...
  end
end
