require "sinatra"
require "sinatra/flash"
require "sinatra/activerecord"

require_relative "models/channel"
require_relative "models/user"

require_relative "./helpers/authentification_helpers"

class Yt < Sinatra::Base
  set :database, ENV["DATABASE_URL"]
  enable :sessions

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  helpers do
    include Sinatra::AuthentificationHelpers

    def partials(page, options = {})
      erb :"partials/#{page}", options.merge!(:layout => false)
    end
  end

  before do
    if !is_authenticated? && needs_autentification?(request.path)
      redirect '/signin'
    end
  end

  get "/" do
    if User.any?
      redirect to("/channels/new")
    else
      redirect to("/setup")
    end
  end
end

require_relative "controller/channel_controller"
require_relative "controller/user_controller"
