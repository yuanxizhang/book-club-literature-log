class User < ActiveRecord::Base
	has_many :logs
  has_many :user_meetings
  has_many :meetings, through: :user_meetings
  belongs_to :book_club


  has_secure_password

  validates :username, presence: true
  validates :email, presence: true
  validates :password, presence: true
  validates_uniqueness_of :username
  validates_uniqueness_of :email


  def slug
      self.username.strip.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
      self.all.find {|item| item.slug == slug}
  end
end