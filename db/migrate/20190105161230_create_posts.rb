class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.references :match, foreign_key: true
      t.references :team, foreign_key: true
      t.references :player, foreign_key: true
      t.references :play_type, foreign_key: true
      t.integer :minute
      t.text :description

      t.timestamps
    end
  end
end
