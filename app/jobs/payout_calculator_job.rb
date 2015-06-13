class PayoutCalculatorJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(bet_id)
    payout_object = PayoutCalculator.new(Bet.find(bet_id)).payout_determiner
    payout_object[:winner].each_with_index do |usr,idx|
      Bank.pay_to_account(bet_id,User.find(usr),payout_object[:amount][idx],payout_object[:money_type])
    end
  end

end
