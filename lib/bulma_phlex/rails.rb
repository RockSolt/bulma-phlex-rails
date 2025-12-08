# frozen_string_literal: true

require "bulma-phlex"
require "zeitwerk"

loader = Zeitwerk::Loader.for_gem_extension(BulmaPhlex)
loader.setup

module BulmaPhlex
  module Rails
    # Your code goes here...
  end
end
