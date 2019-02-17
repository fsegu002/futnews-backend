class AddMatchIdToMatches < ActiveRecord::Migration[5.2]
  def change
    add_column :matches, :match_id, :integer
  end
end
