# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class FormFieldTest < ComponentTestCase
      def test_renders_field_and_label_with_content
        component = FormField.new(:project, :name) { "Input Control" }
        output = render component

        expected_html = <<~HTML.strip
          <div class="field">
            <label class="label" for="project_name">Name</label>
            <div class="control">
              Input Control
            </div>
          </div>
        HTML

        assert_html_equal expected_html, output
      end

      def test_includes_help_text_when_provided
        component = FormField.new(:project, :name, help: "This is help text.") { "Input Control" }
        output = render(component)

        expected_html = <<~HTML.strip
          <div class="field">
            <label class="label" for="project_name">Name</label>
            <div class="control">
              Input Control
            </div>
            <p class="help">This is help text.</p>
          </div>
        HTML

        assert_html_equal expected_html, output
      end
    end
  end
end
