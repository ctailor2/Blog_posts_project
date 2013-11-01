class Tagging < ActiveRecord::Base
  # Remember to create a migration!
  belongs_to :post
  belongs_to :tag
end
