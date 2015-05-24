class Game < ActiveRecord::Base
  belongs_to :summoner

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
                         #killing_sprees: ['stats']['killingSprees'] || 0,
                         summoner_id: Summoner.find_by(lol_id: summoner.lol_id).id)
    end
  end
end
