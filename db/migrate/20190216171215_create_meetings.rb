class CreateMeetings < ActiveRecord::Migration
  def change
  	create_table :meetings do |t|
      t.string :topic
  		t.string :date_and_time
  		t.string :location
  		t.integer :book_club_id
    end
  end
end
