class Course < ActiveRecord::Base
  validates :title, :department, :location, :professor, presence: true
  validates :title, uniqueness: true

  belongs_to :user
end
