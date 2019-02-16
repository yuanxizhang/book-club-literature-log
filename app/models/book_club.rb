class BookClub < ActiveRecord::Base
  has_many :users
  has_many :meetings

  validates :name, presence: true
  validates :about, presence: true
  validates :organizer, presence: true
end