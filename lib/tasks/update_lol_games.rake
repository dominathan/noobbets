namespace :update_lol_games do
  desc 'Run this task to get the top 500 players from the website'
  task :get_summoner_info => :environment do
    puts "Getting Summoners.........."
    GetRiotAPI.delay.get_summoner_ids(GetTopSummoners.get_from_lolking(40))
    puts 'Summoners Done.'
  end

  desc 'Get list of recent games for all players'
  task :get_recent_games => :environment do
    puts 'Updating Games for Summoners...........'
    GetRiotAPI.delay.get_recent_summoner_games
    puts 'Games for recent summoners done.'
  end
end
