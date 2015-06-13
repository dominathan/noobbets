class Lolteam < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet

  validates_presence_of :user_id, :bet_id
  validates_presence_of :slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7

  before_save :max_entrants_limit_reached?, :unique_summoners_per_lolteam?, :bet_already_started?,
              :user_has_enough_fake_money?

  # Returns the an object of all 7 summoners on a single lolteam with id, name, score,
  # Ending with total_score for all summoners
  def score_user_lolteam
    lolteam = self
    summoner_ids = lolteam.attributes.values.slice(3,7)
    scoring_object = {}
    sum_of_scores_across_summoners = Summoner.where(id: summoner_ids).each_with_index do |summoner,idx|
      scoring_object["slot#{idx + 1}"] = summoner.final_score(lolteam.bet.id)
      scoring_object["id#{idx + 1}"] = summoner.id
      scoring_object["name#{idx + 1}"] = summoner.name
    end
    scoring_object["total_score"] = Summoner.where(id: summoner_ids)
                                            .map { |summoner| summoner.final_score(lolteam.bet.id) }
                                            .reduce(&:+).round(2)
    scoring_object[:user_id] = self.user.id
    scoring_object
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

    def user_has_enough_fake_money?
      self.user.fake_money >= self.bet.cost
    end

end
