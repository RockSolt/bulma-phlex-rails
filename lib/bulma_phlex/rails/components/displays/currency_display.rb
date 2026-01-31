# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Currency Display
    #
    # A read-only display field styled with Bulma that formats a numeric value as
    # currency. This component leverages Rails' `number_to_currency` helper
    # for formatting.
    #
    # Currency options can be passed as a hash to customize the formatting.
    #
    # #### Arguments
    #
    # - `model`: ActiveRecord Model - The model containing the currency attribute. This can also be passed
    #   via the `options` (helpful when using `with_options`).
    # - `method`: Symbol or String - The attribute method name for the currency field.
    # - `options`: Hash - Additional options for the display field. This can include the
    #   `currency_options` key, which should be a hash of options passed to `number_to_currency`.
    class CurrencyDisplay < BaseDisplay
      include Phlex::Rails::Helpers::NumberToCurrency

      def initialize(model, method = nil, **options)
        super(model, method, **options.except(:currency_options))
        @currency_options = options.fetch(:currency_options, {})
      end

      private

      def formatted_value
        number_to_currency(value, @currency_options)
      end
    end
  end
end
