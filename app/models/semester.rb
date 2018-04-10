class Semester < ActiveRecord::Base
  validates :season, :year, presence: true
  validates :year, length: { is: 4 }
  validates :season, inclusion: { in: %w(Spring Summer Fall Winter)}

  belongs_to :user
  has_many :courses
end
