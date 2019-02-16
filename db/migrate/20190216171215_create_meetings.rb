class CreateMeetings < ActiveRecord::Migration
  def change
  	create_table :meetings do |t|
      t.string :topic
  		t.date :date
  		t.time :start_time
  		t.time :end_time
  		t.string :location
  		t.integer :book_club_id
    end
  end
end
