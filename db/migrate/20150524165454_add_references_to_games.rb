class AddReferencesToGames < ActiveRecord::Migration
  def change
    add_reference :games, :summoner, index: true, foreign_key: true
  end
end
