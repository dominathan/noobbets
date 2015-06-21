namespace :summoner do
  desc 'Update Summoner Score over the Past Week'
  task :update_score => :environment do
    SummonerScoreJob.perform_async
  end
end
