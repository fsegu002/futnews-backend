class CreateTeams < ActiveRecord::Migration[5.2]
  def change
    create_table :teams do |t|
      t.integer :team_id, unique: true
      t.string :name
      t.jsonb :info

      t.timestamps
    end
  end
end
