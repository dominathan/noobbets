require 'open-uri'
require 'uri'
require 'json'

class GetRiotAPI

  # For development, run the following commands on DB:RESET to populate summoners and game data
  #
  # 1.   GetRiotAPI.get_recent_summoner_games
  # 2.   GetRiotAPI.get_summoner_ids(GetTopSummoners.get_from_lolking(3))

  def self.get_summoner_ids(players)
    # An Array of Summoners return from Riot API.
    # Riot Limit is 40 players per request
    y,z = 0,29
    while z < players.length + 40
      uri_safe_players = URI.escape(players[y..z].join(","))
    begin
      players_obj = GetRiotAPI.summoner_information(uri_safe_players)
      Summoner.create_them_all(players_obj)
      sleep(1.5)
      file = nil
    rescue OpenURI::HTTPError, URI::InvalidURIError
      puts $!.message
      sleep(1.5)
      file = nil
    end
      y+=30
      z+=30
    end
  end

  def self.get_recent_summoner_games
    Summoner.all.each do |summoner|
    begin
      game_object = GetRiotAPI.recent_games(summoner.lol_id)
      Game.create_all_games(game_object,summoner)
      sleep(1.3)
    rescue OpenURI::HTTPError, URI::InvalidURIError
      puts $!.message
      sleep(1.3)
    end
    end
  end

  def self.recent_games(summoner_lol_id)
    file = open(URI.escape("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{summoner_lol_id}/recent?api_key=#{ENV['LOL_API_KEY']}")).read
    JSON.parse(file)
  end

  def self.summoner_information(summoner_names)
    file = open(URI.escape("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{summoner_names}?api_key=#{ENV['LOL_API_KEY']}")).read
    JSON.parse(file)
  end

end
