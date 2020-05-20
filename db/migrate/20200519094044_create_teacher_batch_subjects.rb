class CreateTeacherBatchSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :teacher_batch_subjects do |t|
      t.integer :user_id
      t.integer :batch_subject_id

      t.timestamps
    end
  end
end
