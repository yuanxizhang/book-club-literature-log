book_club_list = []

3.times do
  name = ["Graphic Novel Book Club", "Science Fiction Book Club", "Teen Book Club"].sample
  about = "We meet once a month and discuss the books our members selected at the beginning of the year."
  organizer = Faker::Name.first_name

  # Add book club to the list
  book_club_list << [name, about, organizer]
end

book_club_list.each do |name, about, organizer|
  BookClub.create(name: name, about: about, organizer: organizer)
end

meeting_list = []

9.times do
  topic = "Book Discussion: " + Faker::Book.title 
  date_and_time = "First " + ["Monday", "Tuesday", "Wednesday", "Thursday"].sample + " of each month at 6:00 PM."
  location = "Berkeley Public Library " + ["North", "West", "South", "Central"].sample + " Branch"
  book_club_id = 1 + rand(3)

  # Add meeting to the list
  meeting_list << [topic, date_and_time, location, book_club_id]
end

meeting_list.each do |topic, date_and_time, location, book_club_id|
  Meeting.create(topic: topic, date_and_time: date_and_time, location: location, book_club_id: book_club_id)
end