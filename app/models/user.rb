class User < ActiveRecord::Base
  has_secure_password
  has_many :courses
  validates_presence_of :name, :password
end
