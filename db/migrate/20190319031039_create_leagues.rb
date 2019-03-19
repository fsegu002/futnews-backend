class CreateLeagues < ActiveRecord::Migration[5.2]
  def change
    create_table :leagues do |t|
      t.string  :title
      t.string  :code
      t.string  :country
      t.date    :season_start_date
      t.date    :season_end_date
      t.boolean :active
      t.integer :external_id
      

      t.timestamps
    end
  end
end
