class CreateStudentBatches < ActiveRecord::Migration[6.0]
  def change
    create_table :student_batches do |t|
      t.integer :user_id
      t.integer :batch_id

      t.timestamps
    end
  end
end
