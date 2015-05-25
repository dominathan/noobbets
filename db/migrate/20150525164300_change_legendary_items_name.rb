class ChangeLegendaryItemsName < ActiveRecord::Migration
  def change
    rename_column :games, :legedary_items_created, :legendary_items_created
  end
end
