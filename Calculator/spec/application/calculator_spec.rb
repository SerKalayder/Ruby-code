require 'spec_helper'
require 'calculator'
include CalcApp

describe Calculator do
  context "Standart method" do
    subject do
      params = { :rate => 8, :amount => 1_000_000,
        :time => 8, :method => "standart" }
      Calculator.new(params)
    end

    it "returns table" do
        result = subject.calculate
        expect(result).to be_a(Table)
    end
  end

  context "Annuity method" do
    subject do
      params = { :rate => 8, :amount => 1_000_000,
        :time => 8, :method => "annuity" }
      Calculator.new(params)
    end

    it "returns table" do
        result = subject.calculate
        expect(result).to be_a(Table)
    end
  end

end
