# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class FormButtonLabelTest < ActionView::TestCase
      include TagOutputAssertions

      def test_component
        assert_html_equal <<~HTML, BulmaPhlex::Rails::FormButtonLabel.new("Submit").call
          Submit
        HTML
      end

      def test_with_block
        component = BulmaPhlex::Rails::FormButtonLabel.new("Submit")
        result = component.call { |value| "Button: #{value}" }

        assert_html_equal <<~HTML, result
          Button: Submit
        HTML
      end

      def test_with_icon
        result = BulmaPhlex::Rails::FormButtonLabel.new("Submit", icon_left: "fas fa-check").call

        assert_html_equal <<~HTML, result
          <span class="icon"><i class="fas fa-check"></i></span>
          Submit
        HTML
      end

      def test_with_icon_right
        result = BulmaPhlex::Rails::FormButtonLabel.new("Submit", icon_right: "fas fa-check").call

        assert_html_equal <<~HTML, result
          Submit
          <span class="icon"><i class="fas fa-check"></i></span>
        HTML
      end

      def test_with_both_icons
        result = BulmaPhlex::Rails::FormButtonLabel.new("Submit", icon_left: "fas fa-check",
                                                                  icon_right: "fas fa-arrow-right").call

        assert_html_equal <<~HTML, result
          <span class="icon"><i class="fas fa-check"></i></span>
          Submit
          <span class="icon"><i class="fas fa-arrow-right"></i></span>
        HTML
      end

      def test_with_icon_and_block
        component = BulmaPhlex::Rails::FormButtonLabel.new("Submit", icon_left: "fas fa-check")
        result = component.call { |value| "Button: #{value}" }

        assert_html_equal <<~HTML, result
          <span class="icon"><i class="fas fa-check"></i></span>
          Button: Submit
        HTML
      end
    end
  end
end
