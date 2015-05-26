require 'open-uri'
require 'uri'
require 'json'
#GetPlayerDetails::GetPlayerGames.add_games_to_summoner
#GetPlayerDetails::GetPlayerByName.get_player_object(TopPlayers::Tops.get_top_players(600))

module GetPlayerDetails
  class GetPlayerByName

    def self.get_player_object(players)
      #players is an array returned from ::TopPlayer.  Riot Limit is 40 players per request
      y,z = 0,29
      while z < players.length + 40
        uri_safe_players = URI.escape(players[y..z].join(","))
      begin
        file = open("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{uri_safe_players}?api_key=#{ENV['LOL_API_KEY']}").read
        players_obj = JSON.parse(file)
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
  end

  class GetPlayerGames
    def self.add_games_to_summoner
      Summoner.all.each do |summoner|
      begin
        file = open(URI.escape("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{summoner.lol_id}/recent?api_key=#{ENV['LOL_API_KEY']}")).read
        game_object = JSON.parse(file)
        Game.create_all_games(game_object,summoner)
        sleep(1.3)
      rescue OpenURI::HTTPError, URI::InvalidURIError
        puts $!.message
        sleep(1.3)
      end
      end
    end

  end
end
