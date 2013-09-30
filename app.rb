require "sinatra"
require "sinatra/flash"
require "sinatra/activerecord"

require_relative "models/channel"
require_relative "models/user"

class Yt < Sinatra::Base
  set :database, ENV["DATABASE_URL"]
  enable :sessions

  register Sinatra::ActiveRecordExtension
  register Sinatra::Flash

  helpers do
    def partials(page, options = {})
      erb :"partials/#{page}", options.merge!(:layout => false)
    end
  end

  get "/" do
    redirect to("/channels/new")
  end
end

require_relative "controller/channel_controller"
