require 'spec_helper'
require 'standart_method'
include CalcApp

describe StandartMethod do
  subject do
    StandartMethod.new(10, 100, 5)
  end

  it "returns calculated table with standart method" do
    table = Table.new
    table.body = 100
    table.delta = 30
    table.total = 130
    #(month, payment, percentage, common_payment, remainder)
    table.add_row(1, 20, 10, 30, 80)
    table.add_row(2, 20, 8, 28, 60)
    table.add_row(3, 20, 6, 26, 30)
    table.add_row(4, 20, 4, 24, 20)
    table.add_row(5, 20, 2, 22, 0)

    expect(subject.calculate).to eql table
  end

end
