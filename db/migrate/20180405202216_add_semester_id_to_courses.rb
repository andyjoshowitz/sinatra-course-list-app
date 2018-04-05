class AddSemesterIdToCourses < ActiveRecord::Migration[5.1]
  def change
    add_column :courses, :semester_id, :integer
  end
end
