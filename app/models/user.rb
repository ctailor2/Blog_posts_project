class User < ActiveRecord::Base
  # Remember to create a migration!
  has_many :posts
  has_many :taggings, :through => :posts
  has_many :tags, :through => :taggings
  validates :email, :uniqueness => true
  validates :first_name, :last_name, :email, :password, :presence => true

  def self.authenticate(email, password)
    User.find_by_email_and_password(email, password)
  end

  def self.exists?(email)
    !User.find_by_email(email).nil?
  end

end
