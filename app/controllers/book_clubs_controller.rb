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
    if params["book_club"]["name"].empty?
      flash[:message] = "Please enter name for your book club!"
      redirect to '/book_clubs/new'
    end
    @book_club = BookClub.create(params[:book_club])
     redirect to "/book_clubs"
  end

  # show a book club
  get '/book_clubs/:id' do 
    @book_club = BookClub.find_by_id(params[:id])
    erb :'/book_clubs/show'
  end
end