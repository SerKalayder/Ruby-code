require "sinatra/base"
require 'httparty'
require 'warden'

require_relative "report_generator/report"
require_relative "report_generator/report_generator"
require_relative "storage/storage_provider"

module SeoTools
  class Application < Sinatra::Base
    include Storage
    # Configuration
    set :views, File.dirname(File.expand_path('../../', __FILE__)) + '/views'
    set :public_folder, File.dirname(
      File.expand_path('../../', __FILE__)) + '/public'

    get '/' do
      env['warden'].authenticate!
      #User.create(name: 'serkalayder', password: 'secret')
      sp = StorageProvider.new
      @site_list = sp.all
      puts @site_list
      slim :index
    end

  post '/show' do
      response = HTTParty.get(params[:url])
      if response.success?
        @rg = ReportGenerator.new(params)
        @report = @rg.generate
        slim :report_template
      else
        redirect "/error"
      end
    end

    get '/report/:id' do
      id = params[:id]
      sp = StorageProvider.new
      @report = sp.find(id)
      if @report.is_a(Report)
        slim :report_template
      else
        send_file @report
      end
    end

    get '/error' do
      slim :error
    end

  end





  class Session < Sinatra::Base

    enable :inline_templates

    get '/new' do
      slim :new
    end

    post '/' do
      env['warden'].authenticate!
      flash.success = env['warden'].message
      redirect session[:return_to]
    end

    delete '/' do
      env['warden'].raw_session.inspect
      env['warden'].logout
      flash.success = 'Successfully logged out'
      redirect '/'
    end

    post '/unauthenticated' do
      session[:return_to] = env['warden.options'][:attempted_path]
      flash.error = env['warden'].message
      redirect to '/new'
    end

    not_found do
      redirect '/' # catch redirects to GET '/session'
    end
  end
end


#############
