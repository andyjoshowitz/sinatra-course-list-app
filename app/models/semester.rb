class Semester < ActiveRecord::Base
  validates :season, :year, presence: true
  validates :year, length: { is: 4 }

  belongs_to :user
  has_many :courses
end
