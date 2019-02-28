require './config/environment'
require 'rack-flash'

class ApplicationController < Sinatra::Base

  use Rack::Flash
  
  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "book_club_secret"
  end

  get '/' do
    erb :index
  end

  helpers do
    
    def redirect_if_not_logged_in
      if !logged_in?
        flash[:message] = "Please login to your account to view this page!"
        redirect "/login"
      end
    end

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      if logged_in?
      @user = User.find(session[:user_id])
      end
    end

    def login(user_id)
      session[:user_id] = user_id
    end

    def logout
      session.clear
    end
  end
end