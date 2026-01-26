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

      def select(method, choices = nil, options = {}, html_options = {}, &)
        wrap_field(method, html_options) do |m, html_opts|
          @template.content_tag(:div, class: "select") do
            html_opts[:class].pop # Remove 'input' class added by wrap_field
            super(m, choices, options, html_opts, &)
          end
        end
      end

      # rubocop:disable Metrics/ParameterLists
      def collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
        wrap_field(method, html_options) do |m, html_opts|
          @template.content_tag(:div, class: "select") do
            html_opts[:class].pop # Remove 'input' class added by wrap_field
            super(m, collection, value_method, text_method, options, html_opts)
          end
        end
      end
      # rubocop:enable Metrics/ParameterLists

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

      def wrap_field(method, options, &delivered)
        options = options.dup
        options[:class] = Array.wrap(options[:class]) << "input" # select assumes input is last element

        form_field_options = options.extract!(:icon_left, :icon_right, :column, :grid)
                                    .with_defaults(column: @columns_flag, grid: @grid_flag)

        form_field = FormField.new(**form_field_options) do |f|
          f.label { label(method, class: "label").html_safe } unless options.delete(:suppress_label)
          f.control { delivered.call(method, options) }
        end

        form_field.render_in(@template)
      end
    end
  end
end
