require "sinatra"
require "sinatra/activerecord"

require_relative "models/channel"

class Yt < Sinatra::Base
  set :database, ENV["DATABASE_URL"]
  register Sinatra::ActiveRecordExtension

  get "/" do
    redirect to("/channels/new")
  end
end

require_relative "controller/channel_controller"
