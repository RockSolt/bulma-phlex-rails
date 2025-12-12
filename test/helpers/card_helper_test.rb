# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class CardHelperTest < ComponentTestCase
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
              <div class="content">
                <turbo-frame id="my-frame" src="/some-path">
                  <span class="icon"><i class="fas fa-spinner fa-pulse"></i></span>
                  <span>Loading...</span>
                </turbo-frame>
              </div>
            </div>
          </div>
        HTML

        assert_html_equal expected_html, output
      end
    end
  end
end
