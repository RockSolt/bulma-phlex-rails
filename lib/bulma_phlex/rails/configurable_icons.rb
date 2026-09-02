# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # This module provides configurable icons for Bulma Phlex components in a Rails application. It is prepended
    # to the BulmaPhlex::Configuration::Icons module to allow customization of icon classes, such as the
    # turbo_frame_pending icon.
    module ConfigurableIcons
      attr_accessor :turbo_frame_pending

      def initialize(...)
        super
        @turbo_frame_pending = "fa-solid fa-spinner fa-pulse"
      end
    end
  end
end
