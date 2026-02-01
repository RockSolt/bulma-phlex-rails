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
    # - `show_currency` - Display a currency field in a read-only Bulma-styled format.
    # - `show_date` - Display a date field in a read-only Bulma-styled format.
    # - `show_text` - Display a text field in a read
    module DisplayableFormFields
      include BulmaPhlex::Rails::DisplayableBlockOptions

      # Display a currency field in a read-only Bulma-styled format. Include a `currency_format` option
      # to customize the currency format, which will be passed to Rails' `number_to_currency` helper.
      #
      # #### Arguments
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
        render BulmaPhlex::Rails::CurrencyDisplay.new(model, method,
                                                      **options.with_defaults(block_display_options))
      end

      # Display a date field in a read-only Bulma-styled format. Include a `format` option
      # to customize the date format, which will be passed to `to_fs`.
      # Defaults to `:long` format.
      #
      # #### Arguments
      #
      # - `model`: ActiveRecord Model - The model containing the date attribute. This can also be passed
      #   via the `options` (helpful when using `with_options`).
      # - `method`: Symbol or String - The attribute method name for the date field.
      # - `options`: Hash - Additional options for the display field. This can include the `format` key, which gets
      #    passed to `to_fs`.
      #
      # #### Example
      #
      #     show_date(@user, :birthdate, format: :short)
      #     show_date(@event, :start_time)
      #     show_date(:scheduled_at, model: @appointment, format: "%B %d, %Y")
      def show_date(model, method = nil, **options)
        date_options = options.with_defaults(format: :long)
                              .with_defaults(block_display_options)
        render BulmaPhlex::Rails::FormattedDisplay.new(model, method, **date_options)
      end

      # Display a text field in a read-only Bulma-styled format. A custom formatter
      # block can be provided to modify the displayed text.
      #
      # #### Arguments
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
        text_options = options.with_defaults(block_display_options)
        render BulmaPhlex::Rails::TextDisplay.new(model, method, **text_options, formatter: formatter)
      end
    end
  end
end
