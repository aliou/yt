require "time"
require "feedzirra"
require "feedbag"

ONE_DAY = 24 * 60 * 60

class Yt < Sinatra::Base
  get "/channels/?" do
    @channels = Channel.all
    erb :'channel/index'
  end

  get "/channels/new/?" do
    erb :'channel/add'
  end

  post "/channels" do
    @url = params[:url]

    feeds = Feedbag.find @url
    if !feeds.empty?
      feed = Feedzirra::Feed.fetch_and_parse(feeds.first)
      Channel.create(:url => @url,
		     :feed => feeds.first,
		     :title => feed.title,
		     :last_fetched => Time.now - ONE_DAY)
    end

    @channels = Channel.all
    erb :'channel/index'
  end

  # TODO: Check if channel exists or wrap around exception block.
  delete "/channels/:id" do
    Channel.destroy(params[:id])
    status 200
  end
end
