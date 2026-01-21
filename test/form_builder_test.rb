# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class FormBuilderTestBase < ActionView::TestCase
      include TagOutputAssertions

      # Create a simple model for testing
      class TestModel
        include ActiveModel::Model

        attr_accessor :name, :email, :password, :description

        def self.model_name
          ActiveModel::Name.new(self, nil, "TestModel")
        end
      end

      def setup
        @model = TestModel.new(name: "John Doe", email: "john@example.com")
        @form = FormBuilder.new(
          :test_model,
          @model,
          view_context,
          {}
        )
      end

      private

      def view_context
        @view_context ||= controller.view_context
      end

      def controller
        @controller ||= ActionView::TestCase::TestController.new
      end
    end

    class FormBuilderFormFieldTest < FormBuilderTestBase
      def test_text_field_renders_with_label_and_control
        html = @form.text_field(:name)

        # Check it has the field structure
        assert_match(/class="field"/, html)
        assert_match(/class="label"/, html)
        assert_match(/class="control"/, html)
        assert_match(/class="input"/, html)
        assert_match(/type="text"/, html)
        assert_match(/name="test_model\[name\]"/, html)

        assert_html_equal <<~HTML, html
          <div class = "field">
            <label class="label" for="test_model_name">Name</label>
            <div class="control">
              <input class="input" type="text" value="John Doe" name="test_model[name]" id="test_model_name" />
            </div>
          </div>
        HTML
      end
    end

    class FormBuilderInputFieldsTest < FormBuilderTestBase
      def test_password_field
        assert_match(/type="password"/,
                     @form.password_field(:password))
      end

      def test_email_field
        assert_match(/type="email"/,
                     @form.email_field(:email))
      end

      def test_color_field
        assert_match(/type="color"/,
                     @form.color_field(:name))
      end

      def test_search_field
        assert_match(/type="search"/,
                     @form.search_field(:name))
      end

      def test_telephone_field
        assert_match(/type="tel"/,
                     @form.telephone_field(:name))
      end

      def test_phone_field
        assert_match(/type="tel"/, @form.phone_field(:name))
      end

      def test_date_field
        assert_match(/type="date"/,
                     @form.date_field(:name))
      end

      def test_time_field
        assert_match(/type="time"/,
                     @form.time_field(:name))
      end

      def test_datetime_field
        assert_match(/type="datetime-local"/,
                     @form.datetime_field(:name))
      end

      def test_datetime_local_field
        assert_match(/type="datetime-local"/,
                     @form.datetime_local_field(:name))
      end

      def test_month_field
        assert_match(/type="month"/,
                     @form.month_field(:name))
      end

      def test_week_field
        assert_match(/type="week"/,
                     @form.week_field(:name))
      end

      def test_url_field
        assert_match(/type="url"/,
                     @form.url_field(:name))
      end

      def test_number_field
        assert_match(/type="number"/,
                     @form.number_field(:name))
      end

      def test_range_field
        assert_match(/type="range"/,
                     @form.range_field(:name))
      end

      def test_field_with_options
        html = @form.text_field(:name, class: "is-large", placeholder: "Enter name")

        assert_match(/placeholder="Enter name"/, html)
        assert_match(/class="input is-large"/, html)
      end
    end
  end
end
