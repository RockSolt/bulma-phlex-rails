# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Formatted Display
    #
    # A read-only display field styled with Bulma. This requires a `format` option,
    # which will be passed to `to_fs` for formatting the value.
    #
    # #### Arguments
    #
    # - `model`: ActiveRecord Model - The model containing the attribute to display.
    # - `method`: Symbol or String - The attribute method name for the field.
    # - `options`: Hash - Additional Bulma form field options can be passed, such as `:help`,
    #   `:icon_left`, `:icon_right`, `:column`, and `:grid`. Include a `format` key to specify
    #   the format to use with `to_fs`.
    class FormattedDisplay < TextDisplay
      def initialize(model, method = nil, **options)
        super(model, method, **options.except(:format))
        @format = options.fetch(:format, :default)
      end

      private

      def formatted_value
        value.to_fs(@format)
      end
    end
  end
end
