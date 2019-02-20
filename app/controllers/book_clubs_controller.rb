class BookClubsController < ApplicationController
	register Sinatra::ActiveRecordExtension
  set :session_secret, "my_application_secret"
  set :views, Proc.new { File.join(root, "../views/") }


	get '/book_clubs' do
    @book_clubs = BookClub.all
    erb :'/book_clubs/book_clubs' 
  end

  # Create a book club
  get '/book_clubs/new' do
    if logged_in?
      @user = current_user
      erb :"/book_clubs/new"
    else
      redirect to '/login'
    end
  end

  post '/book_clubs' do
    @book_club = BookClub.new(
        name: params["book_club"]["name"], 
        about: params["book_club"]["about"], 
        organizer: params["book_club"]["organizer"])
    if params[:meeting][:topic]!= ""
        @book_club.meetings << Meeting.create(params[:meeting])
    end

    @book_club.user_ids = params[:book_club][:users]
    @book_club.meeting_ids = params[:book_club][:meetings]
    @book_club.save
    flash[:message] = "Successfully created book club: #{@book_club.name}."
       
    redirect to "/book_clubs"

    if @book_club.errors.any?
        @book_club.errors.each{|attr, msg| flash[:message] = "#{attr} - #{msg}" }
        redirect to '/book_clubs/new'
    end   
  end

  # show a book club
  get '/book_clubs/:id' do 
    @book_club = BookClub.find_by_id(params[:id])
    erb :'/book_clubs/show'
  end

  # Edit a book club
  get '/book_clubs/:id/edit' do
    if logged_in?
      @book_club = BookClub.find_by_id(params[:id])
      if @book_club.organizer.downcase == current_user.username.downcase
          erb :"/book_clubs/edit"
      else
        flash[:message] = "Only the organizer of the #{@book_club.name} can edit the book club's profile."

        erb :'/book_clubs/book_clubs'
      end
    else
      redirect to '/login'
    end 
  end

  patch '/book_clubs/:id' do 
    if params["book_club"]["name"].empty?
      flash[:message] = "Please enter topic for your book club!"
      redirect to "/book_clubs/#{params[:id]}/edit"
    elsif params["book_club"]["about"].empty?
      flash[:message] = "Please enter the date and time for your book club!"
      redirect to "/book_clubs/#{params[:id]}/edit"
    elsif params["book_club"]["organizer"].empty?
      flash[:message] = "Please enter an organizer for your book club!"
      redirect to "/book_clubs/#{params[:id]}/edit"
    end

    @book_club = BookClub.find(params[:id])
    if @book_club.organizer.downcase == current_user.username.downcase
      redirect to (@book_club.update(params[:book_club]) ? "/book_clubs/#{@book_club.id}" : "/book_clubs/#{@book_club.id}/edit")
    else
      redirect to '/book_clubs'
    end
  end

end