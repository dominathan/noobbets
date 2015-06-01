class CreateLolteams < ActiveRecord::Migration
  def change
    create_table :lolteams do |t|
      t.references :user, index: true, foreign_key: true
      t.references :bet, index: true, foreign_key: true
      t.integer :slot1
      t.integer :slot2
      t.integer :slot3
      t.integer :slot4
      t.integer :slot5
      t.integer :slot6
      t.integer :slot7

      t.timestamps null: false
    end
  end
end
