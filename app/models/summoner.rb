class Summoner < ActiveRecord::Base
  has_many :games

  validates_presence_of :name, :lol_id
  validates_uniqueness_of :lol_id

  # 2 points per kill
  # -0.5 points per death
  # 1.5 points per assist
  # 0.01 points per creep kill
  # 2 points for a triple kill
  # 5 points for a quadra kill (doesn't also count as a triple kill)
  # 10 points for a penta kill (doesn't also count as a quadra kill)
  # 2 points if a player attains 10 or more assists or kills in a game (this bonus only applies once)
  # 3 points for first blood
  # 3 points for win

  def final_score(bet_id)
    # Still missing points for winning
    myarr = array_of_scored_attributes(bet_id)
    # Should create a new array of the scoring mechanism above, and then call
    # myarr.map.with_index { |elm, idx| elm * otherarr[idx] }
    # This will allow for better testing and transition.
    total = [myarr[0]*2.0,myarr[1]*-0.5,myarr[2]*1.5,myarr[3]*0.01,myarr[4]*2.0,
                    myarr[5]*5.0,myarr[6]*10.0,myarr[7]*3].reduce(&:+)
    if myarr[3] > 10 || myarr[0] > 10
      total += 2
    end
  end

  def array_of_scored_attributes(bet_id)
    total_sum_per_scoring_category = scoring_categories.map do |att|
      score_summoner_games_over_bet_timeframe(bet_id,att)
    end
    total_sum_per_scoring_category
  end

  def scoring_categories
    ['champions_killed','num_deaths','assists','minions_killed','triple_kills',
      'quadra_kills','penta_kills','first_blood']
  # win is also an attribute, but we don't want to loop over it.
  end

  def score_summoner_games_over_bet_timeframe(bet_id,desired_attribute)
    bet = Bet.find(bet_id)
    #[kills*2, deaths*-0.5,assist*1.5,minions_killed*0.01, triple_kill*2, quadra_kill*5, penta_kill*10, assist > 10 ? 2 : 0, kills > 10 ? 2 : 0, first_blood ? 3 : 0]
    games.where("create_date >= :start_time AND create_date <= :end_time",
                 {start_time: bet.start_time, end_time: bet.end_time})
         .sum(desired_attribute)
  end

  def self.create_summoner(obj)
    if Summoner.find_by(lol_id: obj.last['id']) == nil
      Summoner.create(lol_id: obj.last["id"], name: obj.last['name'])
    end
  end

  def self.create_them_all(json_object)
    json_object.each do |person|
      Summoner.create_summoner(person)
    end
  end
end
