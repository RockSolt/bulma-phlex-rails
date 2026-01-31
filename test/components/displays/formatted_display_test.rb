# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class FormattedDisplayTest < ComponentTestCase
      class TestModel
        include ActiveModel::Model

        attr_accessor :start_date

        def self.model_name
          ActiveModel::Name.new(self, nil, "TestModel")
        end
      end

      def setup
        super
        @model = TestModel.new(start_date: Date.new(1976, 7, 6))
      end

      def test_renders_correctly
        component = BulmaPhlex::Rails::FormattedDisplay.new(@model, :start_date)
        html = component.render_in(view_context)

        assert_html_equal <<~HTML, html
          <div class="field">
            <label class="label">Start date</label>
            <div class="control">
              <input type="text" class="input is-light" type="text" value="1976-07-06" readonly />
            </div>
          </div>
        HTML
      end

      def test_date_with_long_format
        component = BulmaPhlex::Rails::FormattedDisplay.new(@model, :start_date, format: :long)
        html = component.render_in(view_context)

        assert_match(/value="July 06, 1976"/, html)
      end
    end
  end
end
