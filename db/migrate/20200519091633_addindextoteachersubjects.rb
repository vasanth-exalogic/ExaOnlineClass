class Addindextoteachersubjects < ActiveRecord::Migration[6.0]
  def change
    add_index :teacher_subjects, [:user_id, :subject_id], unique: true
  end
end
