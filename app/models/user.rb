class User < ActiveRecord::Base
  validates :name, :password, presene: true

  has_secure_password
  has_many :courses
end
