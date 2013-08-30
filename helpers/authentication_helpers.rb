require "sinatra/base"

require_relative "../models/user"

module Sinatra
  module AuthenticationHelpers
    def is_authenticated?
      session[:user_id]
    end

    def needs_authentication?(path)
      return false if ENV["RACK_ENV"] == "test"
      return false if path == "/login" or path == "/logout"
      return false if path =~ /css/ or path =~ /js/
      true
    end

    def current_user
      User.find(session[:user_id])
    end
  end
end
