require "date"
require "feedbag"
require "feedzirra"
require "mail"

def fetch_channels
  message = ""
  get_new_videos.each do |video|
    message += "<a href=\"#{video.url}\">#{video.title}</a><br />"
  end
  send_mail message unless message == ""
end

def get_new_videos
  current_time = Time.now
  videos = []
  Channel.all.each do |c|
    feed = Feedzirra::Feed.fetch_and_parse(c.feed)
    if feed.last_modified > c.last_fetched
      videos += feed.entries.select { |f| f.published > c.last_fetched }
    end
    c.last_fetched = current_time
    c.save!
  end
  videos.sort! { |a,b| a.published <=> b.published }
end

def send_mail(message)
  Mail.defaults do
    delivery_method :smtp, {
      :address => 'smtp.sendgrid.net',
      :port => 587,
      :domain => 'heroku.com',
      :user_name => ENV['SENDGRID_USERNAME'],
      :password => ENV['SENDGRID_PASSWORD'],
      :authentication => 'plain',
      :enable_starttls_auto => true
    }
  end

  Mail.deliver do
    from ENV["YT_MAIL_ADR"]
    to ENV["YT_USER_ADR"]
    subject "Youtube new videos for #{Date.today.to_s}"
    text_part do
      content_type 'text/html; charset=UTF-8'
      body message
    end
  end
end
