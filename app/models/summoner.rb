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
  # 3 points for first blood
  # 3 points for win

  def final_score(bet_id)
    array_of_scored_attributes(bet_id).map.with_index { |elm,idx| elm * scoring_values[idx] }
                                      .reduce(&:+)
  end

  def array_of_scored_attributes(bet_id)
    scoring_categories.map { |att| score_summoner_games_over_bet_timeframe(bet_id,att) }
  end

  def scoring_categories
    ['champions_killed','num_deaths','assists','minions_killed','triple_kills',
      'quadra_kills','penta_kills','first_blood','win']
  end

  def scoring_values
    [2.0,-0.5,1.5,0.01,2.0,5.0,10.0,3,3]
  end

  def score_summoner_games_over_bet_timeframe(bet_id,desired_attribute)
    bet = Bet.find(bet_id)
    if desired_attribute == 'win'
      games.where("create_date >= :start_time AND create_date <= :end_time",
                   {start_time: bet.start_time, end_time: bet.end_time})
           .where(win: true)
           .count
    else
      games.where("create_date >= :start_time AND create_date <= :end_time",
                   {start_time: bet.start_time, end_time: bet.end_time})
           .sum(desired_attribute)
    end
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
