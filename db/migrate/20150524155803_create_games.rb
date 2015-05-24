class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :num_deaths
      t.integer :champions_killed
      t.boolean :win
      t.integer :minions_killed
      t.datetime :create_date
      t.integer :timePlayed
      t.integer :assists
      t.integer :total_damage_dealt
      t.integer :total_damage_taken
      t.integer :total_damage_dealt_to_champion
      t.integer :killing_sprees

      t.timestamps null: false
    end
  end
end
