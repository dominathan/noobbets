class Game < ActiveRecord::Base
  belongs_to :summoner

  validates_presence_of :lol_game_id
  validates_presence_of :create_date
  validates_presence_of :summoner_id
  validates_uniqueness_of :lol_game_id, scope: :summoner_id

  def self.create_all_games(games_objects,summoner)
    games_objects['games'].each { |game| Game.create_game(game,summoner) }
  end

  def self.create_game(game,summoner)
    if !Game.find_by(lol_game_id: game['gameId'])
            Game.create(lol_game_id: game["gameId"],
                         num_deaths: game['stats']['numDeaths'] || 0,
                         champions_killed: game['stats']['championsKilled'] || 0,
                         win: game['stats']['win'],
                         minions_killed: game['stats']['minionsKilled'] || 0,
                         create_date: Time.at(game['createDate'] / 1000),
                         assists: game['stats']['assists'] || 0,
                         total_damage_dealt: game['stats']['totalDamageDealt'] || 0,
                         total_damage_taken: game['stats']['totalDamageTaken'] || 0,
                         total_damage_dealt_to_champion: game['stats']['totalDamageDealtToChampions'] || 0,
                         killing_sprees: game['stats']['killingSprees'] || 0,
                         barracks_killed: game['stats']['barracksKilled'] || 0,
                         combat_player_score: game['stats']['combatPlayerScore'] || 0,
                         consumables_purchased: game['stats']['consumablesPurchased'] || 0,
                         damage_dealt_player: game['stats']['damageDealtPlayer'] || 0,
                         double_kills: game['stats']['doubleKills'] || 0,
                         first_blood: game['stats']['firstBlood'] || 0,
                         gold: game['stats']['gold'] || 0,
                         gold_earned: game['stats']['goldEarned'] || 0,
                         gold_spent: game['stats']['goldSpent'] || 0,
                         item0: game['stats']['item0'] || 0,
                         item1: game['stats']['item1'] || 0,
                         item2: game['stats']['item2'] || 0,
                         item3: game['stats']['item3'] || 0,
                         item4: game['stats']['item4'] || 0,
                         item5: game['stats']['item5'] || 0,
                         item6: game['stats']['item6'] || 0,
                         items_purchased: game['stats']['itemsPurchased'] || 0,
                         largest_critical_strike: game['stats']["largestCriticalStrike"] || 0,
                         largest_killing_spree: game['stats']['largestKillingSpree'] || 0,
                         largest_multi_kill: game['stats']["largestMultiKill"] || 0,
                         legendary_items_created: game['stats']['legendaryItemsCreated'] || 0,
                         level: game['stats']["level"] || 0,
                         magic_damage_dealt_player: game['stats']['magicDamageDealtPlayer'] || 0,
                         magic_damage_dealt_to_champions: game['stats']["magicDamageDealtToChampions"] || 0,
                         magic_damage_taken: game['stats']['magicDamageTaken'] || 0,
                         minions_denied: game['stats']['minionsDenied'] || 0,
                         neutral_minions_killed: game['stats']['neutralMinionsKilled'] || 0,
                         neutral_minions_killed_enemy_jungle: game['stats']['neutralMinionsKilledEnemyJungle'] || 0,
                         neutral_minions_killed_your_jungle: game['stats']['neutralMinionsKilledYourJungle'] || 0,
                         nexus_killed: game['stats']['nexusKilled'] || nil,
                         node_capture: game['stats']['nodeCapture'] || 0,
                         node_neutralize_assist: game['stats']['nodeNeutralizeAssist'] || 0,
                         num_items_bought: game['stats']['numItemsBought'] || 0,
                         objective_player_score: game['stats']['objectivePlayerScore'] || 0,
                         penta_kills: game['stats']['pentaKills'] || 0,
                         physical_damage_dealt_player: game['stats']['physicalDamageDealtPlayer'] || 0,
                         physical_damage_taken: game['stats']['physicalDamageTaken'] || 0,
                         physical_damage_dealt_to_champions: game['stats']['physicalDamageDealtToChampion'] || 0,
                         player_position: game['stats']['playerPosition'] || 0,
                         player_role: game['stats']['playerRole'] || 0,
                         quadra_kills: game['stats']['quadraKills'] || 0,
                         sight_wards_bought: game['stats']["siteWardsBought"] || 0,
                         spell_1_cast: game['stats']["spell1Cast"] || 0,
                         spell_2_cast: game['stats']["spell2Cast"] || 0,
                         spell_3_cast: game['stats']["spell3Cast"] || 0,
                         spell_4_cast: game['stats']["spell4Cast"] || 0,
                         summon_spell_1_cast: game['stats']['summonSpell1Cast'] || 0,
                         summon_spell_2_cast: game['stats']['summonSpell2Cast'] || 0,
                         super_monster_killed: game['stats']['superMonsterKilled'] || 0,
                         team: game['stats']['team'] || 0,
                         team_objective: game['stats']['teamObjective'] || 0,
                         time_played: game['stats']['timePlayed'] || 0,
                         total_heal: game['stats']["totalHeal"] || 0,
                         total_player_score: game['stats']['totalPlayerScore'] || 0,
                         total_score_rank: game['stats']['totalScoreRank'] || 0,
                         total_time_crowd_control_dealt: game['stats']['totalTimeCrowdControlDealt'] || 0,
                         total_units_healed: game['stats']["totalUnitsHealed"] || 0,
                         triple_kills: game['stats']['tripleKills'] || 0,
                         true_damage_dealt_player: game['stats']['trueDamageDealtPlayer'] || 0,
                         true_damage_dealt_to_champions: game['stats']["trueDamageDealtToChampions"] || 0,
                         true_damage_taken: game['stats']["trueDamageTaken"] || 0,
                         turrets_killed: game['stats']['turretsKilled'] || 0,
                         unreal_kills: game['stats']['unrealKills'] || 0,
                         victory_point_total: game['stats']['victoryPointTotal'] || 0,
                         vision_wards_bought: game['stats']['visionWardsBought'] || 0,
                         ward_killed: game['stats']["wards_killed"] || 0,
                         ward_placed: game['stats']["wardPlaced"],
                         summoner_id: Summoner.find_by(lol_id: summoner.lol_id).id)
    end
  end

end
