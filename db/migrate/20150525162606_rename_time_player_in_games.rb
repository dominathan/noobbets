class RenameTimePlayerInGames < ActiveRecord::Migration
  def change
    rename_column :games, :time_player, :time_played
    remove_column :games, :timePlayed
  end
end
