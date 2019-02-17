class AddShortNameToTeams < ActiveRecord::Migration[5.2]
  def change
    add_column :teams, :short_name, :string
    add_column :teams, :crest_url, :string
  end
end
