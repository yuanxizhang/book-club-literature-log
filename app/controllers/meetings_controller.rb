class MeetingsController < ApplicationController
	register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }


	get '/meetings' do
    @meetings = Meeting.all
    erb :'/meetings/index' 
  end

  # Create meeting
  get '/meetings/new' do
    if meetingged_in?
      @user = current_user
      erb :"/meetings/new"
    else
      redirect to '/meetingin'
    end
  end

  post '/meetings' do
    if params["content"].empty?
      flash[:message] = "Please enter content for your meeting"
      redirect to '/meetings/new'
    end
    @meeting = current_user.meetings.create(:topic => params[:topic],
      :date => params[:date], :start_time => params[:start_time], :end_time => params[:end_time],
      :location => params[:location])
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
      if @meeting.user.username == current_user.username
          erb :"/meetings/edit_meeting"
      else
        flash[:message] = "You can only edit your own meetings!"
        flash[:message] = "Only #{@meeting.user.username} can update this meeting."

        erb :'/meetings/meetings'
      end
    else
      redirect to '/meetingin'
    end 
  end

  patch '/meetings/:id' do 
    if params["topic"].empty?
      flash[:message] = "Please enter topic for your meeting!"
      redirect to "/meetings/#{params[:id]}/edit"
    end

    meeting = Meeting.find(params[:id])
    if meeting.user == current_user
      redirect to (meeting.update(:topic => params[:topic],
      :date => params[:date], :start_time => params[:start_time], :end_time => params[:end_time],
      :location => params[:location]) ? "/meetings/#{meeting.id}" : "/meetings/#{meeting.id}/edit")
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