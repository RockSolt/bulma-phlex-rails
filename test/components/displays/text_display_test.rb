# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class TextDisplayTest < ComponentTestCase
      class TestModel
        include ActiveModel::Model

        attr_accessor :name

        def self.model_name
          ActiveModel::Name.new(self, nil, "TestModel")
        end
      end

      def setup
        super
        @model = TestModel.new(name: "Sample Text")
      end

      def test_renders_correctly
        component = BulmaPhlex::Rails::TextDisplay.new(@model, :name)
        html = component.render_in(view_context)

        assert_html_equal <<~HTML, html
          <div class="field">
            <label class="label">Name</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="Sample Text" readonly />
            </div>
          </div>
        HTML
      end

      def test_with_form_field_options
        component = BulmaPhlex::Rails::TextDisplay.new(@model, :name, help: "This is a help text",
                                                                      icon_left: "fa fa-user")
        html = component.render_in(view_context)

        assert_html_equal <<~HTML, html
          <div class="field">
            <label class="label">Name</label>
            <div class="control has-icons-left">
              <input type="text" class="input is-light" type="text" value="Sample Text" readonly />
              <span class="icon is-small is-left">
                <i class="fa fa-user"></i>
              </span>
            </div>
            <p class="help">This is a help text</p>
          </div>
        HTML
      end

      def test_text_display_with_formatter
        formatter = lambda(&:upcase)
        component = BulmaPhlex::Rails::TextDisplay.new(@model, :name, formatter: formatter)
        html = component.render_in(view_context)

        assert_match(/value="SAMPLE TEXT"/, html)
      end
    end
  end
end
