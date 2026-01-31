# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class DisplayableFormFieldsTestBase < ComponentTestCase
      class TestComponent < Phlex::HTML
        include BulmaPhlex::Rails::DisplayableFormFields

        def initialize(model)
          super()
          @model = model
        end
      end

      class TestModel
        include ActiveModel::Model

        attr_accessor :name, :start_date, :amount

        def self.model_name
          ActiveModel::Name.new(self, nil, "TestModel")
        end
      end

      def setup
        super
        @model = TestModel.new(name: "Sample Text", start_date: Date.new(1976, 7, 6), amount: 1234.56)
      end

      def test_show_text
        component = Class.new(TestComponent) do
          def view_template
            show_text @model, :name
          end
        end.new(@model)

        assert_html_equal <<~HTML, render(component)
          <div class="field">
            <label class="label">Name</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="Sample Text" readonly />
            </div>
          </div>
        HTML
      end

      def test_show_text_with_formatter
        component = Class.new(TestComponent) do
          def view_template
            show_text @model, :name, &:upcase
          end
        end.new(@model)

        assert_match(/value="SAMPLE TEXT"/, render(component))
      end

      def test_show_date
        component = Class.new(TestComponent) do
          def view_template
            show_date @model, :start_date
          end
        end.new(@model)

        assert_html_equal <<~HTML, render(component)
          <div class="field">
            <label class="label">Start date</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="July 06, 1976" readonly />
            </div>
          </div>
        HTML
      end

      def test_show_date_with_format_option
        component = Class.new(TestComponent) do
          def view_template
            show_date @model, :start_date, format: :short
          end
        end.new(@model)

        assert_match(/value="06 Jul"/, render(component))
      end

      def test_show_currrency
        component = Class.new(TestComponent) do
          def view_template
            show_currency @model, :amount
          end
        end.new(@model)

        assert_html_equal <<~HTML, render(component)
          <div class="field">
            <label class="label">Amount</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="$1,234.56" readonly />
            </div>
          </div>
        HTML
      end

      def test_show_currency_with_options
        component = Class.new(TestComponent) do
          def view_template
            show_currency @model, :amount, currency_options: { unit: "€", separator: ",", delimiter: "." }
          end
        end.new(@model)

        assert_match(/value="€1.234,56"/, render(component))
      end

      def test_in_columns
        component = Class.new(TestComponent) do
          def view_template
            in_columns do
              show_text @model, :name
              show_date @model, :start_date
            end
          end
        end.new(@model)

        assert_html_equal <<~HTML, render(component)
          <div class="columns">
            <div class="field column">
              <label class="label">Name</label>
              <div class="control">
                <input type="text" class="input is-light" type="text" value="Sample Text" readonly />
              </div>
            </div>
            <div class="field column">
              <label class="label">Start date</label>
              <div class="control">
                <input type="text" class="input is-light" type="text" value="July 06, 1976" readonly />
              </div>
            </div>
          </div>
        HTML
      end

      def test_in_grid
        component = Class.new(TestComponent) do
          def view_template
            in_grid do
              show_text @model, :name
              show_date @model, :start_date
            end
          end
        end.new(@model)

        assert_html_equal <<~HTML, render(component)
          <div class="grid">
            <div class="field cell">
              <label class="label">Name</label>
              <div class="control">
                <input type="text" class="input is-light" type="text" value="Sample Text" readonly />
              </div>
            </div>
            <div class="field cell">
              <label class="label">Start date</label>
              <div class="control">
                <input type="text" class="input is-light" type="text" value="July 06, 1976" readonly />
              </div>
            </div>
          </div>
        HTML
      end

      def test_with_options_handles_model
        component = Class.new(TestComponent) do
          def view_template
            with_options model: @model do
              show_text :name
            end
          end
        end.new(@model)

        assert_html_equal <<~HTML, render(component)
          <div class="field">
            <label class="label">Name</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="Sample Text" readonly />
            </div>
          </div>
        HTML
      end
    end
  end
end
