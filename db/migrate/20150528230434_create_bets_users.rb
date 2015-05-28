class CreateBetsUsers < ActiveRecord::Migration
  def change
    create_table :bets_users do |t|
      t.references :bet, index: true, foreign_key: true
      t.references :user, index: true, foreign_key: true
    end
  end
end
