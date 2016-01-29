require_relative "calc_method"

module CalcApp
  class StandartMethod < CalcMethod
    def initialize(rate, amount, time)
      super(rate, amount, time)
      @table.total = (amount + (amount * 2 - (amount*(time-1)/time)) /
                      2.0 * time * @rate).round(2)
      @table.delta = (@table.total - @table.body).round(2)
      @payment = amount / time
    end

    def calculate
      for i in 0...@time
        commonPayment = @amount * @rate + @payment
        interest = (commonPayment - @payment) / @table.body * 100.0
        remainder = @amount - @payment
        @amount -= @payment
        @table.add_row(i+1, @payment.round(2), interest.round(2),
                        commonPayment.round(2), remainder.round(2))
      end
      return @table
    end
  end
end
