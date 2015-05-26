class BetSummonerUser < ActiveRecord::Base
  belongs_to :user
  belongs_to :summoner
  belongs_to :bet
end
