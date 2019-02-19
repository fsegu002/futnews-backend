class AddCodeIndexToPlayTypes < ActiveRecord::Migration[5.2]
  def change
    add_index :play_types, [:code], unique: true
  end
end
