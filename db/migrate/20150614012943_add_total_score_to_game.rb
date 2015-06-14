class AddTotalScoreToGame < ActiveRecord::Migration
  def change
    add_column :games, :total_score, :float
  end
end
