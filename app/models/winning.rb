class Winning < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet
  belongs_to :lolteam

  validates_presence_of :user_id, :bet_id, :lolteam_id, :amount


end
