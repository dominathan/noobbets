class CreateBets < ActiveRecord::Migration
  def change
    create_table :bets do |t|
      t.integer :max_entrants
      t.datetime :start_time
      t.datetime :end_time
      t.integer :entry_fee_in_cents
      t.string :bet_style

      t.timestamps null: false
    end
  end
end
