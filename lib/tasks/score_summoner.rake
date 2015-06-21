namespace :summoner do
  desc 'Update Summoner Score over the Past Week'
  task :update_score => :environment do
    Summoner.all.each do |summoner|
      SummonerScoreJob.perform_async(summoner.id)
    end
  end
end
