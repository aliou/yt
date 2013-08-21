require "date"
require "feedbag"
require "feedzirra"
require 'gmail'

def fetch_channels
end

def get_new_videos
  current_time = Time.now
  videos = []
  Channel.all.each do |c|
    feed = Feedzirra::Feed.fetch_and_parse(c.feed)
    if feed.last_modified > c.last_fetched
      videos += feed.entries.select { |f| f.publish > c.last_fetched }
    end
    c.last_fetched = current_time
    c.save!
  end
  videos
end

def send_mail
end
