# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Checkbox Component
    #
    # This component renders a Bulma-styled checkbox within a form. It integrates with Rails' form builder
    # to ensure proper labeling and value handling.
    #
    # The label can be generated automatically based on the attribute name or customized using a block.
    #
    # Example usage:
    #
    # ```ruby
    # form_with model: @user do |f|
    #   f.checkbox :subscribe_newsletter
    #   f.checkbox :terms_of_service do
    #     span { "I agree to " }
    #     a(href: "/terms") { "the terms and conditions" }
    #   end
    # end
    # ```
    class Checkbox < BulmaPhlex::Base
      def initialize(form_builder, method, options, delivered, label_block)
        @form_builder = form_builder
        @method = method
        @options = options.dup
        @delivered = delivered
        @label_block = label_block

        @options[:class] = Array.wrap(@options[:class]) << "mr-2"
        @form_field_options = @options.extract!(:column, :grid)
                                      .with_defaults(column: @form_builder.columns_flag,
                                                     grid: @form_builder.grid_flag)
      end

      def view_template
        render FormField.new(**@form_field_options) do |f|
          f.control do
            @form_builder.label(@method, nil, class: "checkbox", skip_label_class: true) do |label_builder|
              raw @delivered.call(@options)
              render_label(label_builder)
            end
          end
        end
      end

      private

      def render_label(label_builder)
        output = @label_block ? @label_block.call(label_builder) : label_builder.to_s

        # ActiveSupport::SafeBuffer is html safe, strings are not
        if output.html_safe?
          raw output
        else
          plain output
        end
      end
    end
  end
end
