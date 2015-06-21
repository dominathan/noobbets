class AddScoreToSummoner < ActiveRecord::Migration
  def change
    add_column :summoners, :total_score, :float
  end
end
