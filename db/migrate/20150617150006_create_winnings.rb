class CreateWinnings < ActiveRecord::Migration
  def change
    create_table :winnings do |t|
      t.references :user, index: true, foreign_key: true
      t.references :bet, index: true, foreign_key: true
      t.references :lolteam, index: true, foreign_key: true
      t.integer :amount
      t.boolean :real_money

      t.timestamps null: false
    end
  end
end
