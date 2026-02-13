# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class NestedFormDeleteButtonTest < ActionView::TestCase
      include TagOutputAssertions

      def test_component
        result = NestedFormDeleteButton.new(row_selector: ".row", action: "remove").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-delete-row" data-bulma-phlex--nested-forms-delete-row-row-selector-value=".row" data-action="bulma-phlex--nested-forms-delete-row#remove">
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_label
        result = NestedFormDeleteButton.new(row_selector: ".row", action: "remove", label: "Delete").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-delete-row" data-bulma-phlex--nested-forms-delete-row-row-selector-value=".row" data-action="bulma-phlex--nested-forms-delete-row#remove">
                <span>Delete</span>
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_icon
        result = NestedFormDeleteButton.new(row_selector: ".row", action: "remove", icon_left: "fas fa-trash").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-delete-row" data-bulma-phlex--nested-forms-delete-row-row-selector-value=".row" data-action="bulma-phlex--nested-forms-delete-row#remove">
                <span class="icon"><i class="fas fa-trash"></i></span>
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_label_and_icon
        result = NestedFormDeleteButton.new(row_selector: ".row", action: "remove", label: "Delete",
                                            icon_left: "fas fa-trash").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-delete-row" data-bulma-phlex--nested-forms-delete-row-row-selector-value=".row" data-action="bulma-phlex--nested-forms-delete-row#remove">
                <span class="icon"><i class="fas fa-trash"></i></span>
                <span>Delete</span>
              </button>
            </div>
          </div>
        HTML
      end
    end
  end
end
