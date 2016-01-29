require "sinatra/base"
require_relative "calculator"

module CalcApp
  class Application < Sinatra::Base
    # Configuration
    set :views, File.dirname(File.expand_path('../../', __FILE__)) + '/views'
    set :public_folder, File.dirname(
      File.expand_path('../../', __FILE__)) + '/public'

    get '/' do
      erb :home
    end

    post '/calc' do
      @calc = Calculator.new(params)
      @table = @calc.calculate
      erb :calculations
    end
  end
end
