class UsersController < ApplicationController
  
  get '/signup' do
    if logged_in?
      redirect to '/logs'
    else
      erb :'/users/new'
    end
  end
 
  post '/signup' do 
    @user = User.new(username: params[:username], email: params[:email], password: params[:password])
    @user.book_club = BookClub.find_or_create_by(:name => params[:book_club])
    if @user.save
				session[:user_id] = @user.id				
				login(@user.id)
        redirect to '/logs'
    else
        redirect to '/signup'
    end
  end
 
  get '/login' do
		if logged_in?
      redirect to '/logs'
    else
      erb :'users/login'  
    end
  end

	post "/login" do
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

  # Edit user profile
  get '/users/:slug/edit' do
    if logged_in?
      @user = User.find_by_slug(params[:slug])
      if @user.username == current_user.username
          erb :"/users/edit"
      else
        flash[:message] = "You can only edit your own user profile!"
        erb :'/logs/logs'
      end
    else
      redirect to '/login'
    end 
  end

  patch '/users/:slug' do
    @user = Song.find_by_slug(params[:slug])
    @user.email = params[:user][:email]
    @user.book_club = BookClub.find_or_create_by(name: params[:user][:book_club])
    @user.meeting_ids = params[:user][:meetings]
    if @user.meetings
      @user.meetings.clear
    end
    meetings = params[:user][:meetings]
    meetings.each do |meeting_id|
      @user.meetings << Meeting.find(meeting_id)
    end
    @user.save
    flash[:message] = "Successfully updated user profile."
    redirect to "/users/#{@user.slug}"
  end
  
end
