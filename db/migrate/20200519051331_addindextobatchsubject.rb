class Addindextobatchsubject < ActiveRecord::Migration[6.0]
  def change
    add_index :batch_subjects, [:batch_id, :subject_id], unique: true
  end
end
