# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Form Field Component
    #
    # The Bulma Form Field is a `field` container that groups a label with yielded content
    # (usually an input). It can optionally include a help text.
    #
    # ## Example Usage
    #
    # ```ruby
    # FormField(:project, :name, help: "Enter the project name.") do
    #   text_field :project, :name
    # end
    # ```
    #
    # ## References
    # - [Bulma Form Field](https://bulma.io/documentation/form/general/#form-field)
    class FormField < Phlex::HTML
      include Phlex::Rails::Helpers::Label

      def initialize(object_name, method, **options)
        @object_name = object_name
        @method = method
        @options = options

        @help = options.delete(:help)
      end

      def view_template(&)
        div(class: "field") do
          label(@object_name, @method, class: "label")
          render FormControl.new(&)
          p(class: "help") { @help } if @help
        end
      end
    end
  end
end
