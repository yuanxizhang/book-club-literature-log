class Meeting < ActiveRecord::Base
  belongs_to :book_club
  has_many :user_meetings
  has_many :users, through: :user_meetings

  validates :topic, presence: true
  validates :date_and_time, presence: true 
  validates :location, presence: true
end