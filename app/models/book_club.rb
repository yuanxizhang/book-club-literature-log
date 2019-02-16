class BookClub < ActiveRecord::Base
  has_many :users
  has_many :meetings

  validates :name, presence: true
end