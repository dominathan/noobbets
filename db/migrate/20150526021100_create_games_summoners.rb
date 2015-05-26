class CreateGamesSummoners < ActiveRecord::Migration
  def change
    create_table :games_summoners do |t|
      t.references :game, index: true, foreign_key: true
      t.references :summoner, index: true, foreign_key: true

    end
  end
end
