class User < ActiveRecord::Base
	has_many :logs
  has_many :user_meetings
  has_many :meetings, through: :user_meetings
  belongs_to :book_club

  has_secure_password

  validates_presence_of :username
  validates_uniqueness_of :username
  validates_length_of :username, :in => 3..30

  validates :email, presence: true
  validates :email, email_format: { message: "This doesn't look like an email address" }

  validates :password, presence: true
  validates :password, length: { in: 3..20 }
  
  def slug
      self.username.strip.gsub(" ", "-").downcase
  end

  def self.find_by_slug(slug)
      self.all.find {|item| item.slug == slug}
  end
end