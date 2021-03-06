class Summoner < ActiveRecord::Base
  has_many :games

  validates_presence_of :name, :lol_id
  validates_uniqueness_of :lol_id

  def remove_lol_game_id_duplicates
    grouped_by_lolgame = games.group_by { |val| val.lol_game_id }
    grouped_by_lolgame.values.each do |duplicates|
      keeper = duplicates.shift
      duplicates.each { |remove_me| remove_me.destroy }
    end
  end

  def final_score(bet_id)
    score_summoner_games_over_bet_timeframe(bet_id,'total_score').round(2)
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

  def score_summoner_games_over_bet_timeframe(bet_id,desired_attribute,starting=nil,ending=nil)
    bet = Bet.find(bet_id) || Bet.first
    if desired_attribute == 'win'
      games.where("create_date >= :start_time AND create_date <= :end_time",
                   {start_time: bet.start_time, end_time: bet.end_time})
           .where(win: true)
           .count
    else
      games.where("create_date >= :start_time AND create_date <= :end_time",
                   {start_time: bet.start_time, end_time: bet.end_time})
           .sum(desired_attribute).round(2)
    end
  end

  def final_score_over_user_timeframe(starting,ending)
    score_summoner_games_over_user_timeframe('total_score',starting,ending).round(2)
  end

  def array_of_score_attribute_over_timeframe(starting,ending)
    scoring_categories.map { |att| score_summoner_games_over_user_timeframe(att,starting,ending) }
  end

  def score_summoner_games_over_user_timeframe(desired_attribute,starting,ending)
    if desired_attribute == 'win'
      games.where("create_date >= :start_time AND create_date <= :end_time",
                   {start_time: starting, end_time: ending})
           .where(win: true)
           .count
    else
      games.where("create_date >= :start_time AND create_date <= :end_time",
                   {start_time: starting, end_time: ending})
           .sum(desired_attribute).round(2)
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
