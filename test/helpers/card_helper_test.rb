# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class CardHelperTest < ComponentTestCase
      def setup
        @icons = BulmaPhlex.config.icons
        @original_pending_icon = @icons.turbo_frame_pending
      end

      def teardown
        @icons.turbo_frame_pending = @original_pending_icon
      end

      # mostly this tests that the content gets included, it is not concerned with testing
      # the turbo_frame_tag itself
      module TurboFrameTagMock
        def turbo_frame_tag(*ids, src: nil, _target: nil, **_attributes, &content)
          <<~HTML.html_safe
            <turbo-frame id="#{ids.join(" ")}" src="#{src}">
                  #{content.call}
            </turbo-frame>
          HTML
        end
      end

      # each call to `view_context` returns a new instance, so extend it here
      def view_context
        controller.view_context.extend(TurboFrameTagMock)
      end

      def test_turbo_frame_content_when_rails_available
        component = BulmaPhlex::Card.new do |card|
          card.turbo_frame_content("my-frame", src: "/some-path")
        end
        output = render(component)

        expected_html = <<~HTML
          <div class="card">
            <div class="card-content">
              <turbo-frame id="my-frame" src="/some-path">
                <span class="icon"><i class="fa-solid fa-spinner fa-pulse"></i></span>
                <span>Loading...</span>
              </turbo-frame>
            </div>
          </div>
        HTML

        assert_html_equal expected_html, output
      end

      def test_uses_configured_pending_icon
        BulmaPhlex.config.icons.turbo_frame_pending = "custom-loading-icon"

        component = BulmaPhlex::Card.new do |card|
          card.turbo_frame_content("my-frame")
        end

        assert_includes render(component), "custom-loading-icon"
      end

      def test_pending_icon_option_overrides_configuration
        BulmaPhlex.config.icons.turbo_frame_pending = "configured-loading-icon"

        component = BulmaPhlex::Card.new do |card|
          card.turbo_frame_content("my-frame", pending_icon: "custom-loading-icon")
        end

        output = render(component)

        assert_includes output, "custom-loading-icon"
        refute_includes output, "configured-loading-icon"
      end
    end
  end
end
