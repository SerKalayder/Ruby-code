require 'spec_helper'
require 'app'

include CalcApp

describe Application do
  def app
    a = described_class.allocate
    a.send :initialize
    a
  end

  describe "get '/'" do
    it "returns home page" do
      get '/'
      expect(last_response).to be_ok
      expect(last_response.body).to include("Loan Calculator")
    end
  end

  describe "post '/calc'" do
    it "returns a page with resulting table" do
      post "/calc"
      expect(last_response).to be_ok
      expect(last_response.body).to include("Calculations")
    end
  end
end
