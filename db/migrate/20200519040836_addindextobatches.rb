class Addindextobatches < ActiveRecord::Migration[6.0]
  def change
    add_index :batches, [:batch, :section], unique: true
  end
end
