class AddUserIdToSemesters < ActiveRecord::Migration[5.1]
  def change
    add_column :semesters, :user_id, :integer
  end
end
