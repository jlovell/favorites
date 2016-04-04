class RenameItemToDish < ActiveRecord::Migration
  def change
    rename_table :items, :dishes
    rename_column :ratings, :item_id, :dish_id
  end
end
