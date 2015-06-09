class CreateBanks < ActiveRecord::Migration
  def change
    create_table :banks do |t|
      t.references :bet, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
      t.integer :amount, null: false

      t.timestamps null: false
    end
  end
end
