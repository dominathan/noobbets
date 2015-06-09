class DeleteUserCountFromBet < ActiveRecord::Migration
  def change
    remove_column :bets, :user_count
  end
end
