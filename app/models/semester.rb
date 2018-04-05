class Semester < ActiveRecord::Base
  validates :season, :year, presence: true

  belongs_to :user
  has_many :courses
end
