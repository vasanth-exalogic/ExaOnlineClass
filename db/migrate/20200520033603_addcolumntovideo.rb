class Addcolumntovideo < ActiveRecord::Migration[6.0]
  def change
    add_column :videos, :chapter_id, :integer
  end
end
