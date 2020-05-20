class CreateBatchSubjects < ActiveRecord::Migration[6.0]
  def change
    create_table :batch_subjects do |t|
      t.integer :batch_id
      t.integer :subject_id

      t.timestamps
    end
  end
end
