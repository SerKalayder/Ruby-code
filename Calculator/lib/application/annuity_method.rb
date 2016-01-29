require_relative "calc_method"

module CalcApp
  class AnnuityMethod < CalcMethod
    def initialize(rate, amount, time)
      super(rate, amount, time)

      k = (@rate * ((1 + @rate)**time))/(((1 + @rate)**time)-1)
      @table.total =  (k * amount * time).round(2)
      @table.delta = (@table.total - @table.body).round(2)
      @commonPayment = @table.total / time
    end

    def calculate
      for i in 0...@time
        payment = @commonPayment - @amount * rate
        interest = (@commonPayment - payment) / @table.body * 100.0
        remainder = @amount - payment
        @amount -= payment
        @table.add_row(i+1, payment.round(2), interest.round(2),
                        @commonPayment.round(2), remainder.round(2))
      end
      return @table
    end
  end
end
