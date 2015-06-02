class DropBetsUsers < ActiveRecord::Migration
  def change
    drop_table :bets_users
  end
end
