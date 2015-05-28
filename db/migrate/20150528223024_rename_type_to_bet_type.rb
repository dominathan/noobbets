class RenameTypeToBetType < ActiveRecord::Migration
  def change
    rename_column :bets, :type, :bet_type
  end
end
