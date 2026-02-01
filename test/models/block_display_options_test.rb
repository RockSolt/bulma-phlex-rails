# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class BlockDisplayOptionsTest < Minitest::Test
      def test_returns_options
        options = BlockDisplayOptions.new
        options.push({ model: "test", icon_left: "icon" })

        assert_equal "test", options.current[:model]
        assert_equal "icon", options.current[:icon_left]
      end

      def test_merges_options_on_push
        options = BlockDisplayOptions.new
        options.push({ model: "test" })
        options.push({ icon_left: "icon" })

        assert_equal "test", options.current[:model]
        assert_equal "icon", options.current[:icon_left]
      end

      def test_pop_restores_previous_options
        options = BlockDisplayOptions.new
        options.push({ model: "test" })
        options.push({ icon_left: "icon" })
        options.pop

        assert_equal "test", options.current[:model]
        assert_nil options.current[:icon_left]
      end

      def test_when_columns_is_true
        options = BlockDisplayOptions.new
        options.push({ columns: true })

        assert_equal true, options.current[:column]
        assert_predicate options, :column?
        assert_equal({}, options.column_options)
      end

      def test_when_columns_options_provided
        options = BlockDisplayOptions.new
        options.push({ columns: { gap: "is-4" } })

        assert_predicate options, :column?
        assert options.current[:column]
        assert_equal({ gap: "is-4" }, options.column_options)
      end

      def test_when_grid_is_true
        options = BlockDisplayOptions.new
        options.push({ grid: true })

        assert_equal true, options.current[:grid]
        assert_predicate options, :grid?
        assert_equal({}, options.grid_options)
      end

      def test_when_grid_options_provided
        options = BlockDisplayOptions.new
        options.push({ grid: { columns: 3 } })

        assert_predicate options, :grid?
        assert_equal({ columns: 3 }, options.grid_options)
      end
    end
  end
end
