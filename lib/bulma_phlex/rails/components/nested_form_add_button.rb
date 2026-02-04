# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Nested Form Add Button Component
    #
    # This button can be added to a form to allow users to dynamically add new nested form rows. It uses
    # the Stimulus controller NestedFormsAddRow to handle the addition logic.
    #
    # #### Arguments
    #
    # - `template_id`: String - The ID of the `<template>` element that contains the nested form fields to be added.
    # - `container_selector`: String - A CSS selector that identifies the container element where new rows should
    #   be added.
    # - `label`: String (optional) - The text label to display on the button.
    # - `icon_left`: String (optional) - The name of an icon to display on the left side of the button.
    # - `icon_right`: String (optional) - The name of an icon to display on the right side of the button.
    class NestedFormAddButton < BulmaPhlex::Base
      def initialize(template_id:, # rubocop:disable Metrics/ParameterLists
                     container_selector:,
                     label: nil,
                     icon_left: nil,
                     icon_right: nil,
                     **html_attributes)
        @template_id = template_id
        @label = label
        @icon_left = icon_left
        @icon_right = icon_right
        @container_selector = container_selector
        @html_attributes = html_attributes
      end

      def view_template
        render BulmaPhlex::FormField.new(icon_right: @icon) do
          button(**mix({ type: "button", class: "button", data: stimulus_controller }, @html_attributes)) do
            render BulmaPhlex::Icon(@icon_left) if @icon_left
            span { @label } if @label
            render BulmaPhlex::Icon(@icon_right) if @icon_right
          end
        end
      end

      private

      def stimulus_controller
        { controller: "bulma-phlex--nested-forms-add-row",
          bulma_phlex__nested_forms_add_row_container_selector_value: @container_selector,
          bulma_phlex__nested_forms_add_row_template_id_value: @template_id,
          action: "bulma-phlex--nested-forms-add-row#add" }
      end
    end
  end
end
