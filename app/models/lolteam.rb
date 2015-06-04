class Lolteam < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet

  validates_presence_of :user_id, :bet_id
  validates_presence_of :slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7

  before_save :max_entrants_limit_reached?, :unique_summoners_per_lolteam?

  # Returns the an array of each indiviudal summoner on a single lolteam with id, ending with total
  # E.G. [[179.62, 1965], [555.11, 2136], [550.29, 2276], [198.58, 2251], [308.65, 2367], [143.35, 3477], [265.99, 4017], [2201.59, nil]]
  def score_user_lolteam
    lolteam = self
    summoner_ids = lolteam.attributes.values.slice(3,7)
    sum_of_scores_across_summoners = Summoner.where(id: summoner_ids).map do |summoner|
      summoner.final_score(lolteam.bet.id)
    end
    total_score = sum_of_scores_across_summoners.reduce(&:+)
    return sum_of_scores_across_summoners.append(total_score).zip(summoner_ids)
  end


  private
    def max_entrants_limit_reached?
      self.bet.users.count < self.bet.entrants
    end

    def unique_summoners_per_lolteam?
      self.attributes.values[3,7].uniq == self.attributes.values[3,7]
    end

    def bet_already_started?
      self.bet.start_time > DateTime.now
    end

end
