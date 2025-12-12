# frozen_string_literal: true

require "test_helper"

module BulmaPhlex
  module Rails
    class TableHelperTest < ComponentTestCase
      TestRecord = Data.define(:id, :amount)

      def test_amount_column_adds_currency_formatting
        rows = [TestRecord.new(1, 123.45),
                TestRecord.new(2, 678.90)]

        component = BulmaPhlex::Table.new(rows) do |table|
          table.column "ID", &:id
          table.amount_column "Amount", &:amount
        end
        output = render(component)

        assert_html_includes output, '<th class="has-text-right">Amount</th>'
        assert_html_includes output, '<td class="has-text-right">$123.45</td>'
        assert_html_includes output, '<td class="has-text-right">$678.90</td>'
      end
    end
  end
end
