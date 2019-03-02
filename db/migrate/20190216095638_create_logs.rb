class CreateLogs < ActiveRecord::Migration
  def change
  	create_table :logs do |t|
  		t.string :book_title
		t.string :start_page
		t.string :end_page
		t.string :summary
		t.string :techniques
		t.string :characters
		t.string :word_choice
		t.string :metacognition
		t.string :question    
      	t.integer :user_id
      	t.timestamps
    end
  end
end
