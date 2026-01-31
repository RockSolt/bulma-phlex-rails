# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Base Display
    #
    # Base class for read-only display fields styled with Bulma.
    #
    # This allows the model to be passed via the `model:` option
    # or as the first argument. When the model is passed as an option,
    # the method is assumed to be the first argument.
    class BaseDisplay < BulmaPhlex::Base
      # Keyword arguments accepted by BulmaPhlex::FormField
      FORM_FIELD_OPTIONS = BulmaPhlex::FormField
                           .instance_method(:initialize)
                           .parameters
                           .map { |_, name| name }
                           .freeze

      def initialize(model, method = nil, **options)
        @model = options.fetch(:model, model)
        @method = method || model
        @options = options
      end

      def view_template
        form_field_options = @options.slice(*FORM_FIELD_OPTIONS)
        BulmaPhlex::FormField(**form_field_options) do |field|
          field.label { label(class: "label") { label_text } }
          field.control { control_content }
        end
      end

      private

      def label_text
        model_name = @model.class.name.parameterize(separator: "_")
        ActionView::Helpers::Tags::Translator.new(@model, model_name, @method, scope: "helpers.label").translate
      end

      def control_content
        input type: "text", class: "input is-light", value: formatted_value, readonly: :readonly
      end

      def value
        @model.public_send(@method)
      end

      def formatted_value
        raise NotImplementedError, "Subclasses must implement the formatted_value method"
      end
    end
  end
end
