require_relative "standart_method"
require_relative "annuity_method"

module CalcApp
  class Calculator
    attr_accessor :rate, :amount, :time, :method

    def initialize(params)
      @rate = params[:rate].to_f
      @amount = params[:amount].to_f
      @time = params[:time].to_i
      @method = params[:method]
    end

    def calculate
      if @method == "standart"
        std = StandartMethod.new(@rate, @amount, @time)
        return std.calculate
      else
        ann = AnnuityMethod.new(@rate, @amount, @time)
        return ann.calculate
      end
    end
    
  end
end
