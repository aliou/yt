require "digest/md5"

class Yt < Sinatra::Base
  get "/setup" do
    erb :'user/setup'
  end

  post "/user" do
    if empty?(params) or mismatch?(params)
      flash.now[:error] = "There is an error in your informations. Please try again."
      erb :"user/setup"
    else
      puts params
      User.create(:mail => params[:mail],
                  :password_digest => Digest::MD5.hexdigest(params[:password]))
      redirect to('/')
    end
    puts "k"
  end

  get '/signin' do
    erb :'user/signin'
  end

  post '/signin' do
    user = User.first

    if user.password_digest == Digest::MD5.hexdigest(params[:password])
      session[:user_id] = user.id
      redirect to("/")
    else
      flash.now[:error] = "That's the wrong password. Please Try again."
      erb :'user/signin'
    end
  end

  get '/logout' do
    flash.now[:success] = "You have logged out!"
    session[:user_id] = nil

    redirect to("/")
  end

  private
  def empty?(params)
    params.keys.include?(:mail).nil? or params.keys.include?(:password).nil? ||
      params.keys.include?(:password_confirmation).nil?
  end

  def mismatch?(params)
    params[:password] != params[:password_confirmation]
  end
end
