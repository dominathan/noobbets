class AddRewardToBet < ActiveRecord::Migration
  def change
    add_column :bets, :reward, :integer
  end
end
