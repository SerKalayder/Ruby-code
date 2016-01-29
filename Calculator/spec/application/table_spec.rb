require 'spec_helper'
require 'table'
include CalcApp

describe Table do
  before(:example) do
    @table = Table.new
  end

  context "add_rows" do
    it "it adds row to the table" do
      @table.add_row(5, 100, 10, 100, 500)
      @table.add_row(5, 100, 10, 100, 500)
      expect(@table.rows.size).to eq(2)
    end
  end

  context "rows" do
    it "stores records" do
      row = Table::Row.new
      row.month = 5
      row.payment = 100
      row.percentage = 10
      row.common_payment = 100
      row.remainder = 500

      expect(row.month).to eq(5)
      expect(row.payment).to eq(100)
      expect(row.percentage).to eq(10)
      expect(row.common_payment).to eq(100)
      expect(row.remainder).to eq(500)
    end
  end

end
