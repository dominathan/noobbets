require 'open-uri'
require 'uri'
require 'json'

module GetPlayerDetails
  class GetPlayerByName
    attr_accessor :players

    def self.get_player_object(players)
      players.each do |player|
      begin
        file = open(URI.escape("https://na.api.pvp.net/api/lol/na/v1.4/summoner/by-name/#{player}?api_key=#{ENV['LOL_API_KEY']}")).read
        players_obj = JSON.parse(file)
        Summoner.create_summoner(players_obj)
        sleep(1.0/3)
      rescue OpenURI::HTTPError, URI::InvalidURIError
        print "this fucker doesn't exist"
        sleep(1.0/3)
      end
      end
    end
  end

  class GetPlayerGames

    def self.add_games_to_summoner
      Summoner.all.each do |summoner|
      begin
        file = open(URI.escape("https://na.api.pvp.net/api/lol/na/v1.3/game/by-summoner/#{summoner.lol_id}/recent?api_key=#{ENV['LOL_API_KEY']}")).read
        sleep(1.0/5)
        game_stats = JSON.parse(file)
        games = game_stats['games']
        games.each do |game|
          Game.create_game(game,summoner)
        end
      rescue OpenURI::HTTPError, URI::InvalidURIError
        print 'riot games is being a bitch'
        sleep(1.0/5)
      end
      end
    end

  end
end
