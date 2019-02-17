class CreateMatches < ActiveRecord::Migration[5.2]
  def change
    create_table :matches do |t|
      t.integer :match_day
      t.datetime :utc_date
      t.integer :home_team
      t.integer :away_team
      t.string :status
      t.jsonb :info

      t.timestamps
    end
  end
end
