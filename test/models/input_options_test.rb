# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class InputOptionsTest < ActiveSupport::TestCase
      def test_defaults
        options = InputOptions.new
        refute_predicate options, :suppress_label?
        refute_predicate options, :column?
        refute_predicate options, :cell?
        refute_predicate options, :icon_left?
        refute_predicate options, :icon_right?
      end

      def test_when_suppress_label_is_true
        options = InputOptions.new(suppress_label: true)
        assert_predicate options, :suppress_label?
      end

      def test_when_column_is_true
        options = InputOptions.new(column: true)
        assert_predicate options, :column?
      end

      def test_when_cell_is_true
        options = InputOptions.new(cell: true)
        assert_predicate options, :cell?
      end

      def test_when_icon_left_is_specified
        options = InputOptions.new(icon_left: "icon-class")
        assert_predicate options, :icon_left?
        refute_predicate options, :icon_right?
        assert_equal({ "has-icons-left": true, "has-icons-right": false }, options.icon_control_classes)
      end

      def test_when_icon_right_is_specified
        options = InputOptions.new(icon_right: "icon-class")
        assert_predicate options, :icon_right?
        refute_predicate options, :icon_left?
        assert_equal({ "has-icons-left": false, "has-icons-right": true }, options.icon_control_classes)
      end
    end
  end
end
