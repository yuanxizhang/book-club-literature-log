class Meeting < ActiveRecord::Base
  belongs_to :book_club
  has_many :user_meetings
  has_many :users, through: :user_meetings

  validates :topic, presence: true
  validates :date, presence: true
  validates :location, presence: true
  validates :start_time, presence: true
  validates :end_time, presence: true
end