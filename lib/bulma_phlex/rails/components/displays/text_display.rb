# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Text Display
    #
    # A read-only text display field styled with Bulma.
    #
    # An optional formatter can be provided to customize the display of the text
    # value, such as &:titleize or a custom lambda.
    #
    # #### Arguments
    #
    # - `model`: ActiveRecord Model - The model containing the text attribute.
    # - `method`: Symbol or String - The attribute method name for the text field.
    # - `options`: Hash - Additional Bulma form field options can be passed, such as `:help`,
    #   `:icon_left`, `:icon_right`, `:column`, and `:grid`. Use the `formatter` key to provide
    #   a block or lambda for custom text formatting.
    class TextDisplay < BaseDisplay
      def initialize(model, method, **options)
        super(model, method, **options.except(:formatter))
        @formatter = options[:formatter]
      end

      private

      def formatted_value
        text = value.to_s
        @formatter ? @formatter.call(text) : text
      end
    end
  end
end
