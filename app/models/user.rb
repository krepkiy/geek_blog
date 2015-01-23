class User < ActiveRecord::Base
  has_secure_password
  has_many :posts
  has_many :post_votes

end