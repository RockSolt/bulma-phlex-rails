# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Nested Form Delete Button Component
    #
    # This button can be added to a nested form row to allow users to remove the row. It uses
    # the Stimulus controller NestedFormsDeleteRow to handle the deletion logic.
    #
    # #### Arguments
    #
    # - `row_selector`: String - A CSS selector that identifies the row to be deleted. This is
    #   passed to the element's `closest` method to find the row element.
    # - `action`: String - The action to perform when the button is clicked. This should correspond
    #   to a method in the NestedFormsDeleteRow Stimulus controller. Either "remove" to remove the row
    #   from the DOM, or "markForDestruction" to mark the row for destruction (for existing records).
    # - `label`: String (optional) - The text label to display on the button.
    # - `icon_left`: String (optional) - The name of an icon to display on the left side of the button.
    # - `icon_right`: String (optional) - The name of an icon to display on the right side of the button.
    class NestedFormDeleteButton < BulmaPhlex::Base
      def initialize(row_selector:, # rubocop:disable Metrics/ParameterLists
                     action:,
                     label: nil,
                     icon_left: nil,
                     icon_right: nil,
                     **html_attributes)
        @label = label
        @icon_left = icon_left
        @icon_right = icon_right
        @row_selector = row_selector
        @action = action
        @html_attributes = html_attributes
      end

      def view_template
        render BulmaPhlex::FormField.new do
          BulmaPhlex::Button(icon_left: @icon_left, icon_right: @icon_right, **button_html_attributes) do
            span { @label } if @label
          end
        end
      end

      private

      def button_html_attributes
        mix({ type: "button", data: stimulus_controller }, @html_attributes)
      end

      def stimulus_controller
        { controller: "bulma-phlex--nested-forms-delete-row",
          bulma_phlex__nested_forms_delete_row_row_selector_value: @row_selector,
          action: "bulma-phlex--nested-forms-delete-row##{@action}" }
      end
    end
  end
end
