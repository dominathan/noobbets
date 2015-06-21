class SummonerScoreJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform
    # Do something later
    Summoner.all.each do |summoner|
      score_over_past_week = summoner.final_score_over_user_timeframe(DateTime.now - 7.days, DateTime.now)
      summoner.update_attribute(:total_score,score_over_past_week)
    end
  end
end
