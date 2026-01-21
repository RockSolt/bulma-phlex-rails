# frozen_string_literal: true

module BulmaPhlex
  module Rails
    # # Form Builder
    #
    # This form builder wraps inputs with Bulma Form Fields.
    class FormBuilder < ActionView::Helpers::FormBuilder
      # TODO: Should this include all the related helpers?
      def text_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def password_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def color_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def search_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def telephone_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def phone_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def date_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def time_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def datetime_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def datetime_local_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def month_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def week_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def url_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def email_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def number_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }
      def range_field(method, **options) = wrap_field(method, options) { |m, opts| super(m, opts) }

      private

      def wrap_field(method, options, &delivered)
        options = options.dup
        form_field = FormField.new(object_name, method, options) do
          options[:class] = "input #{options[:class]}".rstrip
          delivered.call(method, options)
        end

        form_field.render_in(@template)
      end
    end
  end
end
