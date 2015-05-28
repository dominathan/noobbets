class ChagneBetNomenclature < ActiveRecord::Migration
  def change
    rename_column :bets, :max_entrants, :entrants
    rename_column :bets, :entry_fee_in_cents, :cost
    rename_column :bets, :bet_style, :type
    add_column    :bets, :completed, :boolean
  end
end
