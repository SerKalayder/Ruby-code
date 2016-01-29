module CalcApp
  class Table
    attr_accessor :body, :delta, :total, :rows

    def initialize
      @body = 0
      @delta = 0
      @total = 0
      @rows = []
    end

    def add_row(month, payment, percentage, common_payment, remainder)
      row = Row.new
      row.month = month
      row.payment = payment
      row.percentage = percentage
      row.common_payment = common_payment
      row.remainder = remainder

      @rows << row
    end

    def eql?(other)
      i = 0
      other.rows.each do |o|
        o == @rows[i]
        i += 1
      end
    end

    class Row
      attr_accessor :month, :payment, :percentage, :common_payment, :remainder
    end

  end
end
