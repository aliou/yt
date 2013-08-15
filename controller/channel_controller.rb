require "feedbag"

class Yt < Sinatra::Base
  get "/channels" do
    @channels = Channel.all

    # erb :'channel/index'
  end

  get "/channels/new" do
    # erb :'channel/add'
  end

  post "/channels" do
    @url = params[:url]

    # Get feeds with Feedbag.
    # Add to db.
    # Catch ActiveRecord exception if feed already exists
  end
end
