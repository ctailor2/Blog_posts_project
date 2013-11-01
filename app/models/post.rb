class Post < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :user
  has_many :taggings
  has_many :tags, :through => :taggings
  validates :title, :presence => true
  validates :body, :presence => true
end
