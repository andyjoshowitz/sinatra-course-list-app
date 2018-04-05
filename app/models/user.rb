class User < ActiveRecord::Base
  validates :name, :password, presence: true

  has_secure_password
  has_many :semesters
  has_many :courses, through: :semesters
end
