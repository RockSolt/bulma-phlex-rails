# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Form Button Label
    #
    # The FormButtonLabel component handles the block content for buttons within forms, allowing
    # icons to be included on either side of the button text.
    class FormButtonLabel < BulmaPhlex::Base
      def initialize(value, icon_left: nil, icon_right: nil)
        @value = value
        @icon_left = icon_left
        @icon_right = icon_right
      end

      def view_template
        render BulmaPhlex::Icon.new(@icon_left) if @icon_left
        raw block_given? ? yield(@value) : plain(@value)
        render BulmaPhlex::Icon.new(@icon_right) if @icon_right
      end
    end
  end
end
