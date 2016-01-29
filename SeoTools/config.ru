# rackup config.ru

# load path to all configs
require ::File.expand_path('../config/environment',  __FILE__)
require "rack/flash"




# run the app
#run SeoTools::Application


builder = Rack::Builder.new do
  Warden::Manager.serialize_into_session{|user| user.id }
  Warden::Manager.serialize_from_session do |id|
    user = DB[:users].where(id: id).first
  end

  Warden::Manager.before_failure do |env,opts|
    env['REQUEST_METHOD'] = 'POST'
  end

  Warden::Strategies.add(:password) do
    def valid?
      params['user'] && params['user']['name'] && params['user']['password']
    end

    def authenticate!
      user = DB[:users].where(email: "admin").first
      user = nil if user[:password] != "12345"
      user.nil? ? fail!('Could not log in') : success!(user, 'Successfully logged in')
    end
  end

  use Rack::MethodOverride
  use Rack::Session::Cookie
  use Rack::Flash, accessorize: [:error, :success]
  use Warden::Manager do |config|
    config.scope_defaults :default,
      strategies: [:password],
      action: 'session/unauthenticated'
    config.failure_app = self
  end

  map '/session' do
    run App::Session
  end

  map '/' do
    run App::Application
  end
end

Rack::Handler::Thin.run builder
