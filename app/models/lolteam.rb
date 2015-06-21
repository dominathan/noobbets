class Lolteam < ActiveRecord::Base
  belongs_to :user
  belongs_to :bet

  validates_presence_of :user_id, :bet_id
  validates_presence_of :slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7

  validate :unique_summoners_per_lolteam?, :max_entrants_limit_reached?, :bet_already_started?,
           :user_has_enough_fake_money?


  # Returns the an object of all 7 summoners on a single lolteam with id, name, score,
  # Ending with total_score for all summoners
  def score_user_lolteam
    lolteam = self
    summoner_ids = lolteam.attributes.values.slice(3,7)
    scoring_object = {}
    sum_of_scores_across_summoners = Summoner.where(id: summoner_ids).each_with_index do |summoner,idx|
      scoring_object["slot#{idx + 1}"] = summoner.final_score(lolteam.bet.id).round(2)
      scoring_object["id#{idx + 1}"] = summoner.id
      scoring_object["name#{idx + 1}"] = summoner.name
    end
    scoring_object['total_score'] = scoring_object['slot1'] + scoring_object['slot2'] + scoring_object['slot3'] + scoring_object['slot4'] + scoring_object['slot5'] + scoring_object['slot6'] + scoring_object['slot7']
    scoring_object[:user_id] = self.user.id
    scoring_object[:lolteam_id] = self.id
    scoring_object
  end

  private
    def max_entrants_limit_reached?
      if self.bet.users.count > self.bet.entrants
        errors.add :base, "Max number of users has been reached.  Please join another bet."
      end
    end

    def unique_summoners_per_lolteam?
      if self.attributes.values[3,7].uniq != self.attributes.values[3,7]
        errors.add :base, "You cannot use a Summoner more than once."
      end
    end

    def bet_already_started?
      if bet.start_time < DateTime.now
        errors.add :base, "This Noobbet has already started.  Please select another."
      end
    end

    def user_has_enough_fake_money?
      if user.fake_money < bet.cost
        errors.add :base, "You do not have enough Boons to join this bet. See 'Getting More Boons'."
      end
    end

end
