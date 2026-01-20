# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Input Options
    #
    # Provides predicates and access to Bulma input-specific options
    class InputOptions
      INPUT_OPTIONS = %i[suppress_label icon_left icon_right column cell].freeze
      attr_reader :icon_left, :icon_right, :column, :cell

      # Removes the Bulma-specific input options from the given options hash, returning
      # the cleaned up hash plus an instance of BulmaPhlex::Rails::InputOptions.
      def self.from_options(options)
        [options.reject(*INPUT_OPTIONS), new(options.select(*INPUT_OPTIONS))]
      end

      def initialize(**options)
        @suppress_label = options.fetch(:suppress_label, false)
        @icon_left = options.fetch(:icon_left, nil)
        @icon_right = options.fetch(:icon_right, nil)
        @column = options.fetch(:column, false)
        @cell = options.fetch(:cell, false)
      end

      def suppress_label?
        !!@suppress_label
      end

      def column?
        !!@column
      end

      def cell?
        !!@cell
      end

      def icon_left?
        @icon_left.present?
      end

      def icon_right?
        @icon_right.present?
      end

      def icon_control_classes
        { "has-icons-left": icon_left?, "has-icons-right": icon_right? }
      end
    end
  end
end
