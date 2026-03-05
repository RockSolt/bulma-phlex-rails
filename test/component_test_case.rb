# frozen_string_literal: true

class ComponentTestCase < Minitest::Test
  include TagOutputAssertions

  def render(...)
    view_context.render(...)
  end

  def view_context
    controller.view_context
  end

  def controller
    @controller ||= ActionView::TestCase::TestController.new
  end
end
