# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Nested Forms
    #
    # This modules provides support for nested forms. It overrides the `fields_for` method to
    # capture the block for nested attributes then creates a template for adding new nested
    # records dynamically when the `nested_form_add_button` method is called.
    #
    # The nested form can also include a delete button for each row using the
    # `nested_form_delete_button` method.
    module NestedForms
      extend ActiveSupport::Concern

      included do
        attr_reader :nested_forms_add_buttons, :nested_forms_templates
      end

      def fields_for(record_name, record_object = nil, fields_options = {}, &block)
        output = super

        if (record_name.is_a?(Symbol) || record_name.is_a?(String)) && nested_attributes_association?(record_name)
          if @nested_forms_add_buttons&.include?(record_name)
            output += build_fields_for_template(record_name, fields_options, &block)
          else
            (@nested_forms_templates ||= {}).store(record_name, [fields_options, block])
          end
        end

        output
      end

      # Add a button to add new nested form rows dynamically.
      #
      # #### Arguments
      #
      # - `record_name`: Symbol or String - The name of the nested association (e.g., :tasks).
      # - `container`: String - A CSS selector that identifies the container element where new rows
      #   should be added.
      # - `label`: String (optional) - The text label to display on the button.
      # - `icon`: String (optional) - The name of an icon to display on the button (appears on the left by default).
      # - `icon_left`: String (optional) - The name of an icon to display on the left side of the button.
      # - `icon_right`: String (optional) - The name of an icon to display on the right side of the button.
      # - Additional HTML attributes can be passed via `html_attributes`.
      def nested_form_add_button(record_name, # rubocop:disable Metrics/ParameterLists
                                 container:,
                                 label: nil,
                                 icon: nil,
                                 icon_left: nil,
                                 icon_right: nil,
                                 **html_attributes)
        button_html = build_nested_form_add_button(record_name, container, label, icon_left || icon, icon_right,
                                                   html_attributes)

        if @nested_forms_templates&.key?(record_name)
          field_options, block = @nested_forms_templates[record_name]
          button_html + build_fields_for_template(record_name, field_options, &block)
        else
          (@nested_forms_add_buttons ||= []) << record_name
          button_html
        end
      end

      # Add a button to delete a nested form row.
      #
      # #### Arguments
      #
      # - `row_selector`: String - A CSS selector that identifies the row to be deleted. This is
      #   passed to the element's `closest` method to find the row element.
      # - `label`: String (optional) - The text label to display on the button.
      # - `icon`: String (optional) - The name of an icon to display on the button (appears on the left by default).
      # - `icon_left`: String (optional) - The name of an icon to display on the left side of the button.
      # - `icon_right`: String (optional) - The name of an icon to display on the right side of the button.
      # - Additional HTML attributes can be passed via `html_attributes`.
      def nested_form_delete_button(row_selector:, # rubocop:disable Metrics/ParameterLists
                                    label: nil,
                                    icon: nil,
                                    icon_left: nil,
                                    icon_right: nil,
                                    **html_attributes)
        action = object.persisted? ? "markForDestruction" : "remove"

        build_nested_form_delete_button(label, icon_left || icon, icon_right, row_selector, action, html_attributes) +
          hidden_field(:_destroy)
      end

      private

      def build_fields_for_template(record_name, fields_options, &block)
        reflection = @object.class.reflect_on_association(record_name.to_sym)
        new_record = reflection.klass.new

        name = "#{@object_name}[#{record_name}_attributes][NEW_RECORD]"
        @template.content_tag(:template, id: "#{@object_name}_#{record_name}_fields_template") do
          fields_for_nested_model(name, new_record, fields_options.merge(child_index: "NEW_RECORD"), block)
        end
      end

      def build_nested_form_add_button(record_name, # rubocop:disable Metrics/ParameterLists
                                       container,
                                       label,
                                       icon_left,
                                       icon_right,
                                       html_attributes)
        BulmaPhlex::Rails::NestedFormAddButton.new(
          template_id: "#{@object_name}_#{record_name}_fields_template",
          label: label,
          icon_left: icon_left,
          icon_right: icon_right,
          container_selector: container,
          **html_attributes
        ).render_in(@template)
      end

      def build_nested_form_delete_button(label, # rubocop:disable Metrics/ParameterLists
                                          icon_left,
                                          icon_right,
                                          row_selector,
                                          action,
                                          html_attributes)
        BulmaPhlex::Rails::NestedFormDeleteButton.new(
          label: label,
          icon_left: icon_left,
          icon_right: icon_right,
          row_selector: row_selector,
          action: action,
          **html_attributes
        ).render_in(@template)
      end
    end
  end
end
