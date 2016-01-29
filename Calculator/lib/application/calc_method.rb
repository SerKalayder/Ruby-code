require_relative "table"

module CalcApp
  class CalcMethod
    attr_accessor :rate, :amount, :time, :table

    def initialize(rate, amount, time)
      @rate = rate / 100.0
      @amount = amount
      @time = time
      @table = Table.new
      @table.body = amount.round(2)
    end
  end

end
