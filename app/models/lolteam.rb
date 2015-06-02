class Lolteam < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet

  validates_presence_of :user_id, :bet_id
  validates_presence_of :slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7

  before_save :max_entrants_limit_reached?, :unique_summoners_per_lolteam?

  private
    def max_entrants_limit_reached?
      self.bet.users.count < self.bet.entrants
    end

    def unique_summoners_per_lolteam?
      self.attributes.values[3,7].uniq == self.attributes.values[3,7]
    end

end
