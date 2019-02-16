class CreateUserMeetings < ActiveRecord::Migration
  def change
  	create_table :book_clubs do |t|
      t.integer :user_id
      t.integer :meeting_id
    end
  end
end
