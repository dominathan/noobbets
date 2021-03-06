class Game < ActiveRecord::Base
  belongs_to :summoner

  validates_presence_of :lol_game_id, :create_date, :summoner_id, :total_score
  validates_uniqueness_of :lol_game_id, scope: :summoner_id

  def calculate_total_score
    score_before_win = scoring_categories_without_win.map.with_index { |category,idx| self[category] * scoring_values[idx] }
                      .reduce(&:+)
    if self['win'] == true
      score_before_win += 3
    end
    score_before_win.round(2)
  end

  def scoring_categories_without_win
    ['champions_killed','num_deaths','assists','minions_killed','triple_kills',
      'quadra_kills','penta_kills','first_blood']
  end

  def scoring_values
    [2.0,-0.5,1.5,0.01,2.0,5.0,10.0,3]
  end

  def self.create_all_games(games_objects,summoner)
    games_objects['games'].each { |game| Game.create_game(game,summoner) }
  end

  def self.create_game(game,summoner)
    summoner.games.create(lol_game_id: game.fetch("gameId",0),
                         num_deaths: game.fetch('stats').fetch('numDeaths',0),
                         champions_killed: game.fetch('stats').fetch('championsKilled',0),
                         win: game.fetch('stats').fetch('win'),
                         minions_killed: game.fetch('stats').fetch('minionsKilled',0),
                         create_date: Time.at(game.fetch('createDate') / 1000),
                         assists: game.fetch('stats').fetch('assists',0),
                         total_damage_dealt: game.fetch('stats').fetch('totalDamageDealt',0),
                         total_damage_taken: game.fetch('stats').fetch('totalDamageTaken',0),
                         total_damage_dealt_to_champion: game.fetch('stats').fetch('totalDamageDealtToChampions',0),
                         killing_sprees: game.fetch('stats').fetch('killingSprees',0),
                         barracks_killed: game.fetch('stats').fetch('barracksKilled',0),
                         combat_player_score: game.fetch('stats').fetch('combatPlayerScore',0),
                         consumables_purchased: game.fetch('stats').fetch('consumablesPurchased',0),
                         damage_dealt_player: game.fetch('stats').fetch('damageDealtPlayer',0),
                         double_kills: game.fetch('stats').fetch('doubleKills',0),
                         first_blood: game.fetch('stats').fetch('firstBlood',0),
                         gold: game.fetch('stats').fetch('gold',0),
                         gold_earned: game.fetch('stats').fetch('goldEarned',0),
                         gold_spent: game.fetch('stats').fetch('goldSpent',0),
                         item0: game.fetch('stats').fetch('item0',0),
                         item1: game.fetch('stats').fetch('item1',0),
                         item2: game.fetch('stats').fetch('item2',0),
                         item3: game.fetch('stats').fetch('item3',0),
                         item4: game.fetch('stats').fetch('item4',0),
                         item5: game.fetch('stats').fetch('item5',0),
                         item6: game.fetch('stats').fetch('item6',0),
                         items_purchased: game.fetch('stats').fetch('itemsPurchased',0),
                         largest_critical_strike: game.fetch('stats').fetch("largestCriticalStrike",0),
                         largest_killing_spree: game.fetch('stats').fetch('largestKillingSpree',0),
                         largest_multi_kill: game.fetch('stats').fetch("largestMultiKill",0),
                         legendary_items_created: game.fetch('stats').fetch('legendaryItemsCreated',0),
                         level: game.fetch('stats').fetch("level",0),
                         magic_damage_dealt_player: game.fetch('stats').fetch('magicDamageDealtPlayer',0),
                         magic_damage_dealt_to_champions: game.fetch('stats').fetch("magicDamageDealtToChampions",0),
                         magic_damage_taken: game.fetch('stats').fetch('magicDamageTaken',0),
                         minions_denied: game.fetch('stats').fetch('minionsDenied',0),
                         neutral_minions_killed: game.fetch('stats').fetch('neutralMinionsKilled',0),
                         neutral_minions_killed_enemy_jungle: game.fetch('stats').fetch('neutralMinionsKilledEnemyJungle',0),
                         neutral_minions_killed_your_jungle: game.fetch('stats').fetch('neutralMinionsKilledYourJungle',0),
                         nexus_killed: game.fetch('stats').fetch('nexusKilled',nil),
                         node_capture: game.fetch('stats').fetch('nodeCapture',0),
                         node_neutralize_assist: game.fetch('stats').fetch('nodeNeutralizeAssist',0),
                         num_items_bought: game.fetch('stats').fetch('numItemsBought',0),
                         objective_player_score: game.fetch('stats').fetch('objectivePlayerScore',0),
                         penta_kills: game.fetch('stats').fetch('pentaKills',0),
                         physical_damage_dealt_player: game.fetch('stats').fetch('physicalDamageDealtPlayer',0),
                         physical_damage_taken: game.fetch('stats').fetch('physicalDamageTaken',0),
                         physical_damage_dealt_to_champions: game.fetch('stats').fetch('physicalDamageDealtToChampions',0),
                         player_position: game.fetch('stats').fetch('playerPosition',0),
                         player_role: game.fetch('stats').fetch('playerRole',0),
                         quadra_kills: game.fetch('stats').fetch('quadraKills',0),
                         sight_wards_bought: game.fetch('stats').fetch("sightWardsBought",0),
                         spell_1_cast: game.fetch('stats').fetch("spell1Cast",0),
                         spell_2_cast: game.fetch('stats').fetch("spell2Cast",0),
                         spell_3_cast: game.fetch('stats').fetch("spell3Cast",0),
                         spell_4_cast: game.fetch('stats').fetch("spell4Cast",0),
                         summon_spell_1_cast: game.fetch('stats').fetch('summonSpell1Cast',0),
                         summon_spell_2_cast: game.fetch('stats').fetch('summonSpell2Cast',0),
                         super_monster_killed: game.fetch('stats').fetch('superMonsterKilled',0),
                         team: game.fetch('stats').fetch('team',0),
                         team_objective: game.fetch('stats').fetch('teamObjective',0),
                         time_played: game.fetch('stats').fetch('timePlayed',0),
                         total_heal: game.fetch('stats').fetch("totalHeal",0),
                         total_player_score: game.fetch('stats').fetch('totalPlayerScore',0),
                         total_score_rank: game.fetch('stats').fetch('totalScoreRank',0),
                         total_time_crowd_control_dealt: game.fetch('stats').fetch('totalTimeCrowdControlDealt',0),
                         total_units_healed: game.fetch('stats').fetch("totalUnitsHealed",0),
                         triple_kills: game.fetch('stats').fetch('tripleKills',0),
                         true_damage_dealt_player: game.fetch('stats').fetch('trueDamageDealtPlayer',0),
                         true_damage_dealt_to_champions: game.fetch('stats').fetch("trueDamageDealtToChampions",0),
                         true_damage_taken: game.fetch('stats').fetch("trueDamageTaken",0),
                         turrets_killed: game.fetch('stats').fetch('turretsKilled',0),
                         unreal_kills: game.fetch('stats').fetch('unrealKills',0),
                         victory_point_total: game.fetch('stats').fetch('victoryPointTotal',0),
                         vision_wards_bought: game.fetch('stats').fetch('visionWardsBought',0),
                         ward_killed: game.fetch('stats').fetch("wardKilled",0),
                         ward_placed: game.fetch('stats').fetch("wardPlaced",0),
                         total_score: 0,
                         summoner_id: Summoner.find(summoner.id).id)
    Game.last.update_attribute(:total_score, Game.last.calculate_total_score)
  end

end
