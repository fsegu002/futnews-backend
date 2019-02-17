class CreatePlayers < ActiveRecord::Migration[5.2]
  def change
    create_table :players do |t|
      t.string :name
      t.string :position
      t.date :date_of_birth
      t.string :country_of_birth
      t.string :nationality
      t.integer :shirt_number
      t.references :team, foreign_key: true

      t.timestamps
    end
  end
end
