class CreateBetSummonerUsers < ActiveRecord::Migration
  def change
    create_table :bet_summoner_users do |t|
      t.references :user, index: true, foreign_key: true
      t.references :summoner, index: true, foreign_key: true
      t.references :bet, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
