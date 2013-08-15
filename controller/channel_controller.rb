require "feedzirra"
require "feedbag"

class Yt < Sinatra::Base
  get "/channels" do
    @channels = Channel.all
    erb :'channel/index'
  end

  get "/channels/new" do
    erb :'channel/add'
  end

  post "/channels" do
    @url = params[:url]

    feeds = Feedbag.find @url
    if !feeds.empty?
      feed = Feedzirra::Feed.fetch_and_parse(feeds.first)
      Channel.create(:url => @url, :feed => feed.url, :title => feed.title)
    end

    @channels = Channel.all
    erb :'channel/index'
  end
end
