class AddIconUrlToPlayTypes < ActiveRecord::Migration[5.2]
  def change
    add_column :play_types, :icon_url, :string
  end
end
