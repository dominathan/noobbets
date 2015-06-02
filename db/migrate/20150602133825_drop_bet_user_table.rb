class DropBetUserTable < ActiveRecord::Migration
  def change
    drop_table :bet_users
  end
end
