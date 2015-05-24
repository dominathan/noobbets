class AddFieldsToGames < ActiveRecord::Migration
  def change
    add_column :games, :lol_game_id, :integer
  end
end
