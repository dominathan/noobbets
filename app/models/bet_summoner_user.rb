class BetSummonerUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :summoner
  belongs_to :bet

  validates_presence_of :user_id, :summoner_id, :bet_id


end
