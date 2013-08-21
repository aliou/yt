require "sinatra/activerecord/rake"
require "./app"

require_relative "./tasks/fetch_channels"

desc "Fetch channels and send new videos."
task :fetch_channels do
  fetch_channels
end
