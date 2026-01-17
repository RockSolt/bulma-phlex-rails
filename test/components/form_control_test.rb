# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class FormControlTest < ActiveSupport::TestCase
      include TagOutputAssertions

      def test_renders_div_with_class
        component = FormControl.new

        output = component.call do
          "Content"
        end

        expected_html = <<~HTML.strip
          <div class="control">
            Content
          </div>
        HTML

        assert_html_equal expected_html, output
      end
    end
  end
end
