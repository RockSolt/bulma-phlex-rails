# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Form Control
    #
    # The Bulma Form Control is used to wrap form elements like inputs, selects, and textareas.
    #
    # ## References
    # - [Bulma Form Control](https://bulma.io/documentation/form/general/#form-control)
    class FormControl < Phlex::HTML
      def view_template(&)
        div(class: "control", &)
      end
    end
  end
end
