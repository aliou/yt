require "time"
require "feedzirra"
require "feedbag"

ONE_DAY = 24 * 60 * 60

class Yt < Sinatra::Base
  get "/channels/?" do
    @channels = Channel.all.sort! { |a, b| a.title.downcase <=> b.title.downcase}
    erb :'channel/index'
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
    flash[:success] = "Channel successfully added."
    redirect to("/channels")
  end

  delete "/channels/:id" do
    begin
      Channel.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      return status 404
    end
    Channel.destroy(params[:id])
    status 200
  end
end
