require 'spec_helper'
require 'annuity_method'
include CalcApp

describe AnnuityMethod do
  subject do
    AnnuityMethod.new(10, 100, 5)
  end

  it "returns calculated table with annuity method" do
    table = Table.new
    table.body = 100.00
    table.delta = 31.9
    table.total = 131.9
    #(month, payment, percentage, common_payment, remainder)
    table.add_row(1, 16.38, 10.00, 26.38, 83.62)
    table.add_row(2, 18.02, 8.36, 26.38, 65.60)
    table.add_row(3, 19.82, 6.56, 26.38, 45.78)
    table.add_row(4, 21.80, 4.58, 26.38, 23.98)
    table.add_row(5, 23.98, 2.40, 26.38, 0.00)

    expect(subject.calculate).to eql table
  end

end
