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

      def test_text_field_with_no_label
        html = @form.text_field(:name, suppress_label: true)

        assert_html_equal <<~HTML, html
          <div class = "field">
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
        assert_match(/class="is-large input"/, html)
      end
    end

    class FormBuilderInputIconTest < FormBuilderTestBase
      def test_text_field_renders_with_label_and_control
        html = @form.text_field(:name, icon_left: "fas fa-user")

        assert_html_equal <<~HTML, html
          <div class = "field">
            <label class="label" for="test_model_name">Name</label>
            <div class="control has-icons-left">
              <input class="input" type="text" value="John Doe" name="test_model[name]" id="test_model_name" />
              <span class="icon is-small is-left">
                <i class="fas fa-user"></i>
              </span>
            </div>
          </div>
        HTML
      end
    end

    class FormBuilderSelectTest < FormBuilderTestBase
      def test_select_renders_with_label_and_control
        html = @form.select(:name, ["Option 1", "Option 2"])

        assert_html_equal <<~HTML, html
          <div class = "field">
            <label class="label" for="test_model_name">Name</label>
            <div class="control">
              <div class="select">
                <select class="" name="test_model[name]" id="test_model_name">
                  <option value="Option 1">Option 1</option>
                  <option value="Option 2">Option 2</option>
                </select>
              </div>
            </div>
          </div>
        HTML
      end
    end

    class FormBuilderCollectionSelectTest < FormBuilderTestBase
      def setup
        super
        @collection = [
          @model,
          TestModel.new(name: "Jane Doe", email: "jane@example.com")
        ]
      end

      def test_collection_select_renders_with_label_and_control
        html = @form.collection_select(:name, @collection, :email, :name)

        assert_html_equal <<~HTML, html
          <div class = "field">
            <label class="label" for="test_model_name">Name</label>
            <div class="control">
              <div class="select">
                <select class="" name="test_model[name]" id="test_model_name">
                  <option value="john@example.com">John Doe</option>
                  <option value="jane@example.com">Jane Doe</option>
                </select>
              </div>
            </div>
          </div>
        HTML
      end
    end

    class FormBuilderColumnsTest < FormBuilderTestBase
      def test_columns_wraps_fields_in_columns_div
        html = @form.columns do
          @form.text_field(:name) +
            @form.email_field(:email, column: "two-thirds")
        end

        assert_html_equal <<~HTML, html
          <div class="columns">
            <div class = "field column">
              <label class="label" for="test_model_name">Name</label>
              <div class="control">
                <input class="input" type="text" value="John Doe" name="test_model[name]" id="test_model_name" />
              </div>
            </div>
            <div class = "field column is-two-thirds">
              <label class="label" for="test_model_email">Email</label>
              <div class="control">
                <input class="input" type="email" value="john@example.com" name="test_model[email]" id="test_model_email" />
              </div>
            </div>
          </div>
        HTML
      end
    end

    class FormBuilderGridTest < FormBuilderTestBase
      def test_grid_wraps_fields_in_grid_div
        html = @form.grid do
          @form.text_field(:name) +
            @form.email_field(:email, grid: "col-span-3")
        end

        assert_html_equal <<~HTML, html
          <div class="grid">
            <div class = "field cell">
              <label class="label" for="test_model_name">Name</label>
              <div class="control">
                <input class="input" type="text" value="John Doe" name="test_model[name]" id="test_model_name" />
              </div>
            </div>
            <div class = "field cell is-col-span-3">
              <label class="label" for="test_model_email">Email</label>
              <div class="control">
                <input class="input" type="email" value="john@example.com" name="test_model[email]" id="test_model_email" />
              </div>
            </div>
          </div>
        HTML
      end

      def test_fixed_grid_wraps_fields_in_fixed_grid_div
        html = @form.fixed_grid do
          @form.text_field(:name) +
            @form.email_field(:email, grid: "col-span-3")
        end

        assert_html_equal <<~HTML, html
          <div class="fixed-grid">
            <div class="grid">
              <div class = "field cell">
                <label class="label" for="test_model_name">Name</label>
                <div class="control">
                  <input class="input" type="text" value="John Doe" name="test_model[name]" id="test_model_name" />
                </div>
              </div>
              <div class = "field cell is-col-span-3">
                <label class="label" for="test_model_email">Email</label>
                <div class="control">
                  <input class="input" type="email" value="john@example.com" name="test_model[email]" id="test_model_email" />
                </div>
              </div>
            </div>
          </div>
        HTML
      end
    end
  end
end
