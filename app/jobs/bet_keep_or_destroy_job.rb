class BetKeepOrDestroyJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(bet_id)
    bet = Bet.find_by(id: bet_id)
    if Bet.keep_or_destroy(bet.id)
      PayoutCalculatorJob.perform_at(bet.end_time + 4.hours, bet.id)
    end
  end

end
