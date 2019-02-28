class MeetingsController < ApplicationController

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
    @meeting = Meeting.new(
        topic: params["meeting"]["topic"], 
        date_and_time: params["meeting"]["date_and_time"], 
        location: params["meeting"]["location"])
    @meeting.book_club = BookClub.find_or_create_by(:name => params["meeting"]["book_club"])
    @meeting.save

    if @meeting.save
        redirect to "/meetings"
    else
      if @meeting.errors.any?
        @meeting.errors.each{|attr, msg| flash[:message] = "#{attr} - #{msg}" }
      end
        redirect to '/meetings/new'
    end
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
      if @meeting.book_club.organizer.downcase == current_user.username.downcase
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
    if params["meeting"]["topic"].empty?
      flash[:message] = "Please enter a topic for your meeting!"
      redirect to "/meetings/#{params[:id]}/edit"
    elsif params["meeting"]["date_and_time"].empty?
      flash[:message] = "Please enter the date and time for your book club meeting!"
      redirect to "/meetings/#{params[:id]}/edit"
    elsif params["meeting"]["location"].empty?
      flash[:message] = "Please enter a location for your book club meeting!"
      redirect to "/meetings/#{params[:id]}/edit"
    end

    @meeting = Meeting.find(params[:id])
    if @meeting.book_club.organizer.downcase == current_user.username.downcase
      redirect to (@meeting.update(params[:meeting]) ? "/meetings/#{@meeting.id}" : "/meetings/#{@meeting.id}/edit")
    else
      redirect to '/meetings'
    end
  end

  post '/meetings/:id/delete' do
    @meeting = Meeting.find(params[:id])
    if @meeting.book_club.organizer.downcase != current_user.username.downcase
      flash[:message] = "Sorry only the organizer of the book club can delete this meeting."
      redirect to '/meetings'
    end
    @meeting.delete 
    redirect to '/meetings'
  end
end