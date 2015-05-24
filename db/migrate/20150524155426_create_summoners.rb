class CreateSummoners < ActiveRecord::Migration
  def change
    create_table :summoners do |t|
      t.integer :lol_id
      t.string :name

      t.timestamps null: false
    end
  end
end
