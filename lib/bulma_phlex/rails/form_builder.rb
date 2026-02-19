# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Form Builder
    #
    # This form builder wraps inputs with [Bulma Form Fields](https://bulma.io/documentation/form/general/#form-field).
    #
    # In addition to standard input options, it supports the following Bulma-specific options:
    # - `suppress_label`: If true, the label will not be rendered.
    # - `icon_left`: If set, the specified icon will be rendered on the left side of the input.
    # - `icon_right`: If set, the specified icon will be rendered on the right side of the input.
    # - `column`: If true, the input will be wrapped in a Bulma column (only within a `columns` block).
    # - `grid`: If true, the input will be wrapped in a Bulma grid cell (only within a `grid` block).
    #
    # ## Nested Forms
    #
    # This form builder also includes support for nested forms. Invoke the `nested_form_add_button`
    # method to add a button that allows users to dynamically add new nested form rows. Each
    # nested form row can include a delete button using the `nested_form_delete_button` method.
    class FormBuilder < ActionView::Helpers::FormBuilder # rubocop:disable Metrics/ClassLength
      include NestedForms

      attr_reader :columns_flag, :grid_flag

      def text_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def password_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def color_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def search_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def telephone_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def phone_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def date_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def time_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def datetime_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def datetime_local_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def month_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def week_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def url_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def email_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def number_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def range_field(method, options = {}) = wrap_field(method, options) { |m, opts| super(m, opts) }

      def textarea(method, options = {})
        wrap_field(method, options, add_class: "textarea") do |m, opts|
          super(m, opts)
        end
      end
      alias text_area textarea

      def checkbox(method, options = {}, checked_value = "1", unchecked_value = "0", &label_block)
        delivered = ->(opts) { super(method, opts, checked_value, unchecked_value) }
        Checkbox.new(self, method, options, delivered, label_block).render_in(@template)
      end
      alias check_box checkbox

      def radio_button(method, tag_value, options = {})
        delivered = ->(opts) { super(method, tag_value, opts) }
        RadioButton.new(self, method, tag_value, options, delivered).render_in(@template)
      end

      # Override label to add Bulma's `label` class by default. Add `:skip_label_class` option
      # to skip adding the class.
      def label(method, text = nil, options = {}, &)
        skip_label_class = options.delete(:skip_label_class)
        options[:class] = Array.wrap(options[:class]) << :label unless skip_label_class
        super
      end

      def select(method, choices = nil, options = {}, html_options = {}, &)
        wrap_select_field(method, html_options) do |m, html_opts|
          super(m, choices, options, html_opts, &)
        end
      end

      # rubocop:disable Metrics/ParameterLists

      # The collection_radio_buttons method is overridden to wrap the radio buttons in a Bulma form field and
      # apply the `radio` class to the labels. It does so by passing a block to the original method. If you
      # pass a block this logic will be skipped.
      #
      # Add option `stacked: true` to stack the radio buttons vertically.
      def collection_radio_buttons(method, collection, value_method, text_method, options = {}, html_options = {})
        return super if block_given?

        wrap_field(method, html_options, add_class: false) do |m, html_opts|
          stacked = html_opts.delete(:stacked)
          wrapper_opts = stacked ? {} : { class: "radios" }

          @template.content_tag("div", wrapper_opts) do
            super(m, collection, value_method, text_method, options, html_opts) do |rb|
              rb.label(class: stacked ? "is-block" : "radio") { rb.radio_button(class: "mr-2") + rb.text }
            end
          end
        end
      end

      def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        wrap_select_field(method, html_options) do |m, html_opts|
          super(m, collection, value_method, text_method, options, html_opts)
        end
      end
      # rubocop:enable Metrics/ParameterLists

      def submit(value = nil, options = {})
        if value.is_a?(Hash)
          options = value
          value = nil
        end

        options = options.dup
        options[:class] = Array.wrap(options[:class]) << :button

        FormField.new do
          super(value, options)
        end.render_in(@template)
      end

      # Fields declared in a column block will be wrapped in a Bulma column and carry
      # the `column` class by default (fields can use the `column` option to set sizes).
      #
      # ## Arguments
      #
      # - `minimum_breakpoint`: (Symbol, optional) Sets the minimum breakpoint for the columns; default is `:tablet`.
      # - `multiline`: (Boolean, optional) If true, allows the columns to wrap onto multiple lines.
      # - `gap`: (optional) Use an integer (0-8) to set the gap size between columns; use a hash keyed by breakpoints
      #   to set responsive gap sizes.
      # - `centered`: (Boolean, optional) If true, centers the columns.
      # - `vcentered`: (Boolean, optional) If true, vertically centers the columns.
      def columns(minimum_breakpoint: nil,
                  multiline: false,
                  gap: nil,
                  centered: false,
                  vcentered: false, &)
        @columns_flag = true
        columns = @template.capture(&)
        @columns_flag = false

        BulmaPhlex::Columns.new(minimum_breakpoint:, multiline:, gap:, centered:, vcentered:) do
          @template.concat(columns)
        end.render_in(@template)
      end

      # Fields declared in a grid block will be wrapped in a Bulma fixed grid and carry
      # the `grid` class by default (fields can use the `grid` option to set sizes).
      #
      # ## Arguments
      #
      # - `fixed_columns`: (Integer, optional) Specifies a fixed number of columns for the grid.
      # - `auto_count`: (Boolean, optional) If true, the grid will automatically adjust the number
      #    of columns based on the content.
      # - `minimum_column_width`: (Integer 1-32, optional) Sets a minimum width for the columns in the grid.
      # - `gap`: (optional) Sets the gap size between grid items from 1-8 with 0.5 increments.
      # - `column_gap`: (optional) Sets the column gap size between grid items from 1-8 with 0.5 increments.
      # - `row_gap`: (optional) Sets the row gap size between grid items from 1-8 with 0.5 increments.
      def grid(fixed_columns: nil, # rubocop:disable Metrics/ParameterLists
               auto_count: false,
               minimum_column_width: nil,
               gap: nil,
               column_gap: nil,
               row_gap: nil,
               &)
        @grid_flag = true
        cells = @template.capture(&)
        @grid_flag = false

        BulmaPhlex::Grid.new(fixed_columns:, auto_count:, minimum_column_width:, gap:, column_gap:, row_gap:) do
          @template.concat(cells)
        end.render_in(@template)
      end

      private

      def wrap_field(method, options, add_class: "input", &delivered)
        options = options.dup
        options[:class] = Array.wrap(options[:class]) << add_class if add_class

        form_field_options = options.extract!(:help, :icon_left, :icon_right, :column, :grid)
                                    .with_defaults(column: @columns_flag, grid: @grid_flag)

        form_field = FormField.new(**form_field_options) do |f|
          f.label { label(method).html_safe } unless options.delete(:suppress_label)
          f.control { delivered.call(method, options) }
        end

        form_field.render_in(@template)
      end

      def wrap_select_field(method, html_options, &delivered)
        wrap_field(method, html_options, add_class: false) do |m, html_opts|
          @template.content_tag(:div, class: "select") do
            delivered.call(m, html_opts)
          end
        end
      end
    end
  end
end
