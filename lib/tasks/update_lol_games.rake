namespace :update_lol_games do
  desc 'Run this task to get the top 500 players from the website'
  task :get_summoner_info => :environment do
    puts "Getting Summoners.........."
    GetPlayerDetails::GetPlayerByName.get_player_object(TopPlayers::Tops.get_top_players(30))
    puts 'Summoners Done.'
  end

  desc 'Get list of recent games for all players'
  task :get_recent_games => :environment do
    puts 'Updating Games for Summoners...........'
    GetPlayerDetails::GetPlayerGames.add_games_to_summoner
    puts 'Games for recent summoners done.'
  end
end
