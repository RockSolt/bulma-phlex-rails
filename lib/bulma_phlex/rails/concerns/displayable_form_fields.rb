# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Displayable Form Fields
    #
    # Phlex component mixin to provide displayable form fields to views. These read-only
    # fields provide the same Bulma styling as standard form fields, but are intended for
    # displaying data rather than accepting user input.
    #
    # #### Included Methods
    #
    # - `with_options` - Wrap a block with specific options for displayable fields.
    # - `in_columns` - Wrap a block to display fields in Bulma columns.
    # - `in_grid` - Wrap a block to display fields in a Bulma grid.
    # - `show_currency` - Display a currency field in a read-only Bulma-styled format.
    # - `show_date` - Display a date field in a read-only Bulma-styled format.
    # - `show_text` - Display a text field in a read
    module DisplayableFormFields
      # Wrap a block with specific options for displayable fields. This allows redundant
      # options to be specified once for multiple fields. These options are merged with
      # any options passed directly to the individual field methods.
      #
      # If the `:column` or `:grid` option is provided, the block will be wrapped
      # in a Bulma `columns` or `grid` container, respectively.
      #
      # Blocks can be nested, with inner block options overriding outer block options.
      #
      # #### Example
      #
      #     with_options(model: @user, column: true) do
      #       show_text(:username)
      #       show_date(birthdate, format: :short)
      #     end
      def with_options(**block_options, &)
        (@block_options_stack ||= []) << @block_options
        @block_options = (@block_options || {}).merge(block_options)

        if @block_options[:column]
          div(class: "columns", &)
        elsif @block_options[:grid]
          div(class: "grid", &)
        else
          yield
        end

        @block_options = @block_options_stack.pop
      end

      # Wrap a block to display fields in Bulma columns. This adds a columns container
      # and sets the `column: true` option for any `show_` fields within the block.
      #
      # This is a shorthand for `with_options(column: true) do`.
      def in_columns(&)
        with_options(column: true, &)
      end

      # Wrap a block to display fields in a Bulma grid. This adds a grid container
      # and sets the `grid: true` option for any `show_` fields within the block.
      #
      # This is a shorthand for `with_options(grid: true) do`.
      def in_grid(&)
        with_options(grid: true, &)
      end

      # Display a currency field in a read-only Bulma-styled format. Include a `currency_format` option
      # to customize the currency format, which will be passed to Rails' `number_to_currency` helper.
      #
      # #### Options
      #
      # - `model`: ActiveRecord Model - The model containing the currency attribute. This can also be passed
      #   via the `options` (helpful when using `with_options`).
      # - `method`: Symbol or String - The attribute method name for the currency field.
      # - `options`: Hash - Additional options for the display field. This can include the
      #   `currency_options` key, which should be a hash of options passed to `number_to_currency`.
      #
      # #### Example
      #
      #     show_currency(@order, :total_amount)
      #     show_currency(@product, :price, currency_options: { unit: "€", precision: 2 })
      def show_currency(model, method = nil, **options)
        render BulmaPhlex::Rails::CurrencyDisplay.new(model, method, **options.with_defaults(@block_options || {}))
      end

      # Display a date field in a read-only Bulma-styled format. Include a `format` option
      # to customize the date format, which will be passed to `to_fs`.
      # Defaults to `:long` format.
      #
      # #### Options
      #
      # - `model`: ActiveRecord Model - The model containing the date attribute. This can also be passed
      #   via the `options` (helpful when using `with_options`).
      # - `method`: Symbol or String - The attribute method name for the date field.
      # - `format`: Symbol or String - The date format to use, passed to `to_fs`. Defaults to `:long`.
      #
      # #### Example
      #
      #     show_date(@user, :birthdate, format: :short)
      #     show_date(@event, :start_time)
      #     show_date(:scheduled_at, model: @appointment, format: "%B %d, %Y")
      def show_date(model, method = nil, **options)
        date_options = options.with_defaults(format: :long)
                              .with_defaults(@block_options || {})
        render BulmaPhlex::Rails::FormattedDisplay.new(model, method, **date_options)
      end

      # Display a text field in a read-only Bulma-styled format. A custom formatter
      # block can be provided to modify the displayed text.
      #
      # #### Options
      # - `model`: ActiveRecord Model - The model containing the text attribute. This can also be passed
      #   via the `options` (helpful when using `with_options`).
      # - `method`: Symbol or String - The attribute method name for the text field.
      # - Additional Bulma form field options can be passed, such as `:help`, `:icon_left`, `:icon_right`,
      #   `:column`, and `:grid`.
      #
      # #### Example
      #
      #     show_text(@user, :username)
      #     show_text(@article, :title, &:titleize)
      #     show_text(:email, model: @contact, help: "Primary contact email")
      def show_text(model, method = nil, **options, &formatter)
        text_options = options.with_defaults(@block_options || {})
        render BulmaPhlex::Rails::TextDisplay.new(model, method, **text_options, formatter: formatter)
      end
    end
  end
end
