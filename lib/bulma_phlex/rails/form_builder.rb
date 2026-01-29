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
    class FormBuilder < ActionView::Helpers::FormBuilder
      attr_reader :columns_flag, :grid_flag

      def text_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def password_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def color_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def search_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def telephone_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def phone_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def date_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def time_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def datetime_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def datetime_local_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def month_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def week_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def url_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def email_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def number_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def range_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }

      def textarea(method, **options) = wrap_field(method, options, add_class: "textarea") { |m, opts| super(m, opts) }
      alias text_area textarea

      def checkbox(method, options = {}, checked_value = "1", unchecked_value = "0", &label_block)
        delivered = ->(opts) { super(method, opts, checked_value, unchecked_value) }
        Checkbox.new(self, method, options, delivered, label_block).render_in(@template)
      end
      alias check_box checkbox

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
      def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        wrap_select_field(method, html_options) do |m, html_opts|
          super(m, collection, value_method, text_method, options, html_opts)
        end
      end
      # rubocop:enable Metrics/ParameterLists

      def submit(value = nil, options = {})
        options = options.dup
        options[:class] = Array.wrap(options[:class]) << :button

        FormField.new do |field|
          field.control { super(value, options) }
        end.render_in(@template)
      end

      # Fields declared in a column block will be wrapped in a Bulma column and carry
      # the `column` class by default (fields can use the `column` option to set sizes).
      def columns(min_breakpoint = nil, &)
        @columns_flag = true
        columns = @template.capture(&)
        @columns_flag = false

        @template.content_tag(:div, class: [:columns, min_breakpoint]) do
          @template.concat(columns)
        end
      end

      # Fields declared in a fixed_grid block will be wrapped in a Bulma fixed grid and
      # carry the `grid` class by default (fields can use the `grid` option to set sizes).
      def fixed_grid(&)
        # TODO: Use BulmaPhlex::FixedGrid for more options
        @template.content_tag(:div, class: "fixed-grid") do
          grid(&)
        end
      end

      # Fields declared in a grid block will be wrapped in a Bulma fixed grid and carry
      # the `grid` class by default (fields can use the `grid` option to set sizes).
      def grid(&)
        @grid_flag = true
        cells = @template.capture(&)
        @grid_flag = false

        # TODO: Use BulmaPhlex::Grid for more options
        @template.content_tag(:div, class: "grid") do
          @template.concat(cells)
        end
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
