class Log < ActiveRecord::Base
  belongs_to :user

  validates :book_title, presence: true
  validates :start_page, presence: true
  validates :end_page, presence: true
  validates :summary, presence: true
  validates :techniques, presence: true
  validates :characters, presence: true
  validates :word_choice, presence: true
  validates :metacognition, presence: true
  validates :question, presence: true
end
