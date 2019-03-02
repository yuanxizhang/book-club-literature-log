class UsersController < ApplicationController
  
  get '/signup' do
      erb :'/users/new'
  end
 
  post '/signup' do 
    if params[:email].nil? || params[:username].empty?
      flash[:message] = "Please enter a username!"
      redirect to '/signup'
    elsif params[:email].nil? || params[:email].empty?
      flash[:message] = "Please enter an email!"
      redirect to '/signup'
    elsif params[:password].nil? || params[:password].empty?
      flash[:message] = "Please enter a password!"
      redirect to '/signup'
    end
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    if @user.save
				session[:user_id] = @user.id				
				login(@user.id)
        redirect to '/logs'
    else
        redirect to '/signup'
    end
  end
 
  get '/login' do
    @error_message = params[:error]
		if logged_in?
      redirect to '/logs'
    else
      erb :'users/login'  
    end
  end

	post "/login" do
    if params[:username].nil? || params[:username].empty?
      flash[:message] = "Please enter a username!"
      redirect to '/login'
    elsif params[:password].nil? || params[:password].empty?
      flash[:message] = "Please enter a password!"
      redirect to '/login'
    end
    @user = User.find_by(username: params[:username])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect to '/logs'
    else
      erb :'users/login'
    end
  end
 
  get '/logout' do
    if logged_in?
      session.clear
      redirect to '/login'
    else
    redirect to '/'
    end
  end
 
  get '/users/:slug' do
    @user = User.find_by_slug(params[:slug])
    erb :'/users/show'
  end
  
end
