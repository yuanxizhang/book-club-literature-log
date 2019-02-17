require './config/environment'
require 'rack-flash'

class LogsController < ApplicationController
	enable :sessions
	use Rack::Flash
  register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }

  get '/logs' do
    if logged_in?
    	@user = User.find_by_id(session[:user_id])
      erb :"/logs/logs"
    else
    	redirect to "/login"
    end   
  end

  # Create Log
  get '/logs/new' do
  	if logged_in?
      @user = current_user
  		erb :"/logs/new"
  	else
      redirect to '/login'
    end
  end

  post '/logs' do
  	if params["log"]["book_title"].empty?
      flash[:message] = "Please enter a book title for your log!"
      redirect to '/logs/new'
    end
    @log = current_user.logs.create(params[:log])
     redirect to "/logs"
  end

  # Show Log
  get '/logs/:id' do
    if logged_in?
    	@log = Log.find_by_id(params[:id])
    	erb :'/logs/show_log'
    else
      redirect to '/login'
    end   
  end

   # Edit Log
  get '/logs/:id/edit' do
  	if logged_in?
  		@log = Log.find_by_id(params[:id])
  		if @log.user.username == current_user.username
  				erb :"/logs/edit_log"
  		else
  			flash[:message] = "You can only edit your own reading logs!"
  			flash[:message] = "Only #{@log.user.username} can update this reading log."

  			erb :'/logs/logs'
  		end
  	else
      redirect to '/login'
    end 
  end

  patch '/logs/:id' do 
    if params["log"]["book_title"].empty?
      flash[:message] = "Please enter a book title for your reading log!"
      redirect to "/logs/#{params[:id]}/edit"
    end

    log = Log.find(params[:id])
    if log.user == current_user
      redirect to (log.update(params[:log]) ? "/logs/#{log.id}" : "/logs/#{log.id}/edit")
    else
      redirect to '/logs'
    end
  end

  post '/logs/:id/delete' do
    @log = Log.find(params[:id])
    if current_user.id != @log.user_id
      flash[:message] = "Sorry you can only delete your own reading logs."
      redirect to '/logs'
    end
    @log.delete if @log.user == current_user
    redirect to '/logs'
  end

end




