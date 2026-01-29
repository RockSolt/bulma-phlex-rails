# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class CheckboxTest < ComponentTestCase
      # Create a simple model for testing
      class TestModel
        include ActiveModel::Model

        attr_accessor :active

        def self.model_name
          ActiveModel::Name.new(self, nil, "TestModel")
        end
      end

      def setup
        super
        @model = TestModel.new(active: true)
        @form_builder = BulmaPhlex::Rails::FormBuilder.new(:test_model, @model, view_context, {})
      end

      def test_checkbox
        html = @form_builder.checkbox(:active)

        assert_html_equal <<~HTML, html
          <div class="field">
            <div class="control">
              <label class="checkbox" for="test_model_active">
                <input name="test_model[active]" type="hidden" value="0" autocomplete="off">
                <input type="checkbox" name="test_model[active]" id="test_model_active" value="1" checked="checked" class="mr-2" />
                Active
              </label>
            </div>
          </div>
        HTML
      end

      def test_checkbox_with_label_block_that_returns_string
        html = @form_builder.checkbox(:active) do
          "I agree to the terms and conditions"
        end

        assert_html_equal <<~HTML, html
          <div class="field">
            <div class="control">
              <label class="checkbox" for="test_model_active">
                <input name="test_model[active]" type="hidden" value="0" autocomplete="off">
                <input type="checkbox" name="test_model[active]" id="test_model_active" value="1" checked="checked" class="mr-2" />
                I agree to the terms and conditions
              </label>
            </div>
          </div>
        HTML
      end

      def test_checkbox_with_label_block_that_returns_html
        html = @form_builder.checkbox(:active) do
          view_context.content_tag(:span) { "I agree to the " } +
            view_context.link_to("terms and conditions", "/terms")
        end

        assert_html_equal <<~HTML, html
          <div class="field">
            <div class="control">
              <label class="checkbox" for="test_model_active">
                <input name="test_model[active]" type="hidden" value="0" autocomplete="off">
                <input type="checkbox" name="test_model[active]" id="test_model_active" value="1" checked="checked" class="mr-2" />
                <span>I agree to the </span>
                <a href="/terms">terms and conditions</a>
              </label>
            </div>
          </div>
        HTML
      end

      def test_in_columns
        html = @form_builder.columns do
          @form_builder.checkbox(:active)
        end

        assert_match(/<div class="field column">/, html)
      end

      def test_in_grid
        html = @form_builder.grid do
          @form_builder.checkbox(:active)
        end

        assert_match(/<div class="field cell">/, html)
      end
    end
  end
end
