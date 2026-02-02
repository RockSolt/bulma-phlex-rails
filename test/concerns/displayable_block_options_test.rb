# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class DisplayableBlockOptionsTestBase < Minitest::Test
      include BulmaPhlex::Rails::DisplayableBlockOptions

      def setup
        @div_args = []
        @components = []
      end

      def test_with_options
        with_options(model: "test", icon_left: "icon") do
          assert_equal "test", block_display_options[:model]
          assert_equal "icon", block_display_options[:icon_left]
        end
      end

      def test_in_columns
        in_columns do
          assert block_display_options[:column]
        end

        assert 1, @div_args.size
        assert_instance_of BulmaPhlex::Columns, @components.first
      end

      def test_in_grid
        in_grid do
          assert block_display_options[:grid]
        end
        assert 1, @components.size
        assert_instance_of BulmaPhlex::Grid, @components.first
      end

      def test_in_grid_with_options
        in_grid(fixed_columns: 3, gap: 4) do
          assert block_display_options[:grid]
          assert_equal 3, block_display_options.dig(:grid_options, :fixed_columns)
          assert_equal 4, block_display_options.dig(:grid_options, :gap)
        end
        assert 1, @components.size
        assert_instance_of BulmaPhlex::Grid, @components.first
      end

      private

      def render(component)
        @components << component
      end
    end
  end
end
