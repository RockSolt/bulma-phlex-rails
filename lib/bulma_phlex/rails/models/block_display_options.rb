# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Block Display Options
    #
    # This model enables options to be collected in a nested fashion. It translates
    # column and grid options into a flags for the form fields and stores the full
    # options for the column and grid containers.
    #
    # One small difference between the two is that the column options are specified
    # with a plural (`columms`) in `with_options` but the flag that gets passed to the
    # form fields is singular (`column: true`). For grid options, both are singular
    # (`grid`).
    class BlockDisplayOptions
      def initialize
        @stack = [{}]
        @grid_options = []
        @column_options = []
      end

      def push(options)
        options = options.dup

        # store the columns option, then add a boolean flag
        @column_options.push(options.delete(:columns))
        options[:column] = !!@column_options.last # rubocop:disable Style/DoubleNegation

        # store the grid option, then convert it to a boolean flag
        @grid_options.push(options[:grid])
        options[:grid] = !!options[:grid] # rubocop:disable Style/DoubleNegation

        @stack.push(current.merge(options))
      end

      def pop
        @grid_options.pop
        @stack.pop
      end

      def current
        @stack.last
      end

      def column?
        current[:column]
      end

      def grid?
        current[:grid]
      end

      def column_options
        return {} unless column?

        opts = @column_options.last
        opts == true ? {} : opts
      end

      def grid_options
        return {} unless grid?

        opts = @grid_options.last
        opts == true ? {} : opts
      end
    end
  end
end
