# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Displayable Block Options
    #
    # This concern provides methods to manage display options for Bulma Phlex components,
    # specifically for displayable blocks such as read-only form fields. It allows options
    # to be set for groups of fields, enabling consistent styling and layout.
    #
    # #### Included Methods
    #
    # - `with_options` - Wrap a block with specific options for displayable fields.
    # - `in_columns` - Wrap a block to display fields in Bulma columns.
    # - `in_grid` - Wrap a block to display fields in a Bulma grid.
    module DisplayableBlockOptions
      # Wrap a block with specific options for displayable fields. This allows redundant
      # options to be specified once for multiple fields. These options are merged with
      # any options passed directly to the individual field methods.
      #
      # If the `:columns` or `:grid` option is provided, the block will be wrapped
      # in a Bulma `columns` or `grid` container, respectively.
      #
      # Blocks can be nested, with inner block options overriding outer block options.
      #
      # #### Example
      #
      #     with_options(model: @user, column: true) do
      #       show_text(:username)
      #       show_date(birthdate, format: :short)
      #     end
      def with_options(**block_options, &)
        (@_block_display_options ||= BlockDisplayOptions.new).push(block_options)

        if @_block_display_options.column?
          div(class: "columns", &)
        elsif @_block_display_options.grid?
          render BulmaPhlex::Grid.new(**@_block_display_options.grid_options, &)
        else
          yield
        end

        @_block_display_options.pop
      end

      # Retrieve the current block display options.
      def block_display_options
        @_block_display_options&.current || {}
      end

      # Wrap a block to display fields in Bulma columns. This adds a columns container
      # and sets the `column: true` option for any `show_` fields within the block.
      #
      # This is a shorthand for `with_options(column: true) do`.
      def in_columns(&)
        with_options(columns: true, &)
      end

      # Wrap a block to display fields in a Bulma grid. This adds a grid container
      # and sets the `grid: true` option for any `show_` fields within the block.
      #
      # You can optionally pass in any [Grid options](https://github.com/RockSolt/bulma-phlex#grid) as a hash.
      def in_grid(options = true, &) # rubocop:disable Style/OptionalBooleanParameter
        with_options(grid: options, &)
      end
    end
  end
end
