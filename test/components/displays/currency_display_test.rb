# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class CurrencyDisplayTest < ComponentTestCase
      class TestModel
        include ActiveModel::Model

        attr_accessor :amount

        def self.model_name
          ActiveModel::Name.new(self, nil, "TestModel")
        end
      end

      def setup
        super
        @model = TestModel.new(amount: 1234.56)
      end

      def test_renders_correctly
        component = BulmaPhlex::Rails::CurrencyDisplay.new(@model, :amount)
        html = component.render_in(view_context)

        assert_html_equal <<~HTML, html
          <div class="field">
            <label class="label">Amount</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="$1,234.56" readonly />
            </div>
          </div>
        HTML
      end

      def test_with_currency_options
        currency_options = { unit: "€", separator: ",", delimiter: "." }
        component = BulmaPhlex::Rails::CurrencyDisplay.new(@model, :amount, currency_options:)
        html = component.render_in(view_context)

        assert_match(/value="€1.234,56"/, html)
      end
    end
  end
end
