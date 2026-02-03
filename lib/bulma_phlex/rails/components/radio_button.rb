# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Checkbox Component
    class RadioButton < BulmaPhlex::Base
      def initialize(form_builder, method, tag_value, options, delivered)
        @form_builder = form_builder
        @method = method
        @tag_value = tag_value
        @options = options.dup
        @delivered = delivered

        @options[:class] = Array.wrap(@options[:class]) << "mr-2"
        @form_field_options = @options.extract!(:column, :grid)
                                      .with_defaults(column: @form_builder.columns_flag,
                                                     grid: @form_builder.grid_flag)
      end

      def view_template
        render FormField.new(**@form_field_options) do
          label(class: "radio") do
            raw @delivered.call(@options)
            plain label_from_tag_value
          end
        end
      end

      private

      def label_from_tag_value
        key = [@method, @tag_value.to_s.downcase.gsub(/\s+/, "_")].join("_")
        I18n.translate(key, scope: [:helpers, :label, @form_builder.object_name],
                            default: @tag_value.to_s.humanize)
      end
    end
  end
end
