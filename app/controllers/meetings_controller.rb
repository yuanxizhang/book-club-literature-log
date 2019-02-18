class MeetingsController < ApplicationController
	register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }


	get '/meetings' do
    @meetings = Meeting.all
    erb :'/meetings/meetings' 
  end

  # Create meeting
  get '/meetings/new' do
    if logged_in?
      @user = current_user
      erb :"/meetings/new"
    else
      redirect to '/login'
    end
  end

  post '/meetings' do
    if params["content"].empty?
      flash[:message] = "Please enter content for your meeting"
      redirect to '/meetings/new'
    end
    @meeting = current_user.meetings.create(params[:meeting])
     redirect to "/meetings"
  end

  # Show meeting
  get '/meetings/:id' do 
    @meeting = Meeting.find_by_id(params[:id])
    erb :'/meetings/show'
  end

   # Edit Meeting
  get '/meetings/:id/edit' do
    if logged_in?
      @meeting = Meeting.find_by_id(params[:id])
      if @meeting.book_club.organizer == current_user.username
          erb :"/meetings/edit"
      else
        flash[:message] = "Only organizer of #{@meeting.book_club.name} can update this meeting."

        erb :'/meetings/meetings'
      end
    else
      redirect to '/login'
    end 
  end

  patch '/meetings/:id' do 
    if params["topic"].empty?
      flash[:message] = "Please enter topic for your meeting!"
      redirect to "/meetings/#{params[:id]}/edit"
    end

    meeting = Meeting.find(params[:id])
    if meeting.book_club.organizer == current_user.username
      redirect to (meeting.update(params[:meeting]) ? "/meetings/#{meeting.id}" : "/meetings/#{meeting.id}/edit")
    else
      redirect to '/meetings'
    end
  end

  post '/meetings/:id/delete' do
    @meeting = Meeting.find(params[:id])
    if current_user.id != @meeting.user_id
      flash[:message] = "Sorry you can only delete your own meetings"
      redirect to '/meetings'
    end
    @meeting.delete if @meeting.user == current_user
    redirect to '/meetings'
  end
end