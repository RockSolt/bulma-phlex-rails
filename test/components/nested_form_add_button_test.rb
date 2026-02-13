# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class NestedFormAddButtonTest < ActionView::TestCase
      include TagOutputAssertions

      def test_component
        result = NestedFormAddButton.new(template_id: "template-id", container_selector: ".container").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-add-row" data-bulma-phlex--nested-forms-add-row-container-selector-value=".container" data-bulma-phlex--nested-forms-add-row-template-id-value="template-id" data-action="bulma-phlex--nested-forms-add-row#add">
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_label
        result = NestedFormAddButton.new(template_id: "template-id",
                                         container_selector: ".container",
                                         label: "Add Item").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-add-row" data-bulma-phlex--nested-forms-add-row-container-selector-value=".container" data-bulma-phlex--nested-forms-add-row-template-id-value="template-id" data-action="bulma-phlex--nested-forms-add-row#add">
                <span>Add Item</span>
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_icon
        result = NestedFormAddButton.new(template_id: "template-id",
                                         container_selector: ".container",
                                         icon_left: "fas fa-plus").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-add-row" data-bulma-phlex--nested-forms-add-row-container-selector-value=".container" data-bulma-phlex--nested-forms-add-row-template-id-value="template-id" data-action="bulma-phlex--nested-forms-add-row#add">
                <span class="icon"><i class="fas fa-plus"></i></span>
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_label_and_icon
        result = NestedFormAddButton.new(template_id: "template-id",
                                         container_selector: ".container",
                                         label: "Add Item",
                                         icon_left: "fas fa-plus").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button" data-controller="bulma-phlex--nested-forms-add-row" data-bulma-phlex--nested-forms-add-row-container-selector-value=".container" data-bulma-phlex--nested-forms-add-row-template-id-value="template-id" data-action="bulma-phlex--nested-forms-add-row#add">
                <span class="icon"><i class="fas fa-plus"></i></span>
                <span>Add Item</span>
              </button>
            </div>
          </div>
        HTML
      end

      def test_with_additional_html_attributes
        result = NestedFormAddButton.new(template_id: "template-id",
                                         container_selector: ".container",
                                         label: "Add Item",
                                         data: { test_attr: "value" },
                                         class: "is-primary").call

        assert_html_equal <<~HTML, result
          <div class="field">
            <div class="control">
              <button type="button" class="button is-primary" data-controller="bulma-phlex--nested-forms-add-row" data-bulma-phlex--nested-forms-add-row-container-selector-value=".container" data-bulma-phlex--nested-forms-add-row-template-id-value="template-id" data-action="bulma-phlex--nested-forms-add-row#add" data-test-attr="value">
                <span>Add Item</span>
              </button>
            </div>
          </div>
        HTML
      end
    end
  end
end
