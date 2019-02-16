class CreateBookClubs < ActiveRecord::Migration
  def change
  	create_table :book_clubs do |t|
      t.string :name
      t.string :about
      t.string :organizer
    end
  end
end
