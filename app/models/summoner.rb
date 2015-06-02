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
    total_value_of_columns = array_of_scored_attributes(bet_id)
    final_score = total_value_of_columns.map.with_index { |elm,idx| elm * scoring_values[idx] }
                                        .reduce(&:+)
    # This will allow for better testing and transition.
    if total_value_of_columns[2] > 10 || total_value_of_columns[0] > 10
      final_score += 2
    end
    final_score
  end

  def array_of_scored_attributes(bet_id)
    scoring_categories.map { |att| score_summoner_games_over_bet_timeframe(bet_id,att) }
  end

  def scoring_categories
    ['champions_killed','num_deaths','assists','minions_killed','triple_kills',
      'quadra_kills','penta_kills','first_blood']
  # win is also an attribute, but we don't want to loop over it.
  end

  def scoring_values
    [2.0,-0.5,1.5,0.01,2.0,5.0,10.0,3]
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
