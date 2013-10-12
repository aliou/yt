module Sinatra
  module AuthentificationHelpers
    def is_authenticated?
      session[:user_id]
    end

    def needs_autentification?(path)
      return false if !User.any?
      return false if path == "/signin" or path == "/setup"
      return false if path =~ /js/ or path =~ /css/ or path =~ /font/
      true
    end
  end
end

