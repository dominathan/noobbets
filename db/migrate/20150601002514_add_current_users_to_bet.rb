class AddCurrentUsersToBet < ActiveRecord::Migration
  def change
    add_column :bets, :user_count, :integer, default: 0
  end
end
