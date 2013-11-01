class Tag < ActiveRecord::Base
  # Remember to create a migration!
  has_many :taggings
  has_many :posts, :through => :taggings
end
