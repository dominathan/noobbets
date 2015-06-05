class AddFakeMoneyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :fake_money, :integer
  end
end
