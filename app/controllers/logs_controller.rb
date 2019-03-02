require './config/environment'
require 'rack-flash'

class LogsController < ApplicationController

  get '/logs' do
    redirect_if_not_logged_in
    @user = User.find_by_id(session[:user_id])
    erb :"/logs/logs"
  end

  # Create Log
  get '/logs/new' do
  	  redirect_if_not_logged_in
      @error_message = params[:error]
      @user = current_user
  		erb :"/logs/new"
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
      redirect_if_not_logged_in
    	@log = Log.find_by_id(params[:id])
    	erb :'/logs/show_log'
  end

   # Edit Log
  get '/logs/:id/edit' do
      redirect_if_not_logged_in
      @error_message = params[:error]
  		@log = Log.find_by_id(params[:id])
  		if @log.user.username == current_user.username
  				erb :"/logs/edit"
  		else
  			flash[:message] = "You can only edit your own reading logs!"
  			erb :'/logs/logs'
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




