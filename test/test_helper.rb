# frozen_string_literal: true

# Suppress Phlex-related 'method redefined' warnings
module Warning
  def self.warn(msg)
    return if msg =~ %r{gems/phlex}i

    super
  end
end

# Define Turbo module for testing purposes; this causes the CardHelper to be included
module Turbo; end # rubocop:disable Style/OneClassPerFile

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require "bulma-phlex-rails"
require "minitest/autorun"
require "nokogiri"
require "active_model"
require "active_support/test_case"
require "action_view/test_case"
require "tag_output_assertions"
require "component_test_case"
