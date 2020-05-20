class CreateChapters < ActiveRecord::Migration[6.0]
  def change
    create_table :chapters do |t|
      t.integer :batch_subject_id
      t.string :title
      t.text :overview

      t.timestamps
    end
  end
end
