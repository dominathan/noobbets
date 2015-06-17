class PayoutCalculatorJob < ActiveJob::Base
  include Sidekiq::Worker
  queue_as :default

  def perform(bet_id)
    payout_object = PayoutCalculator.new(Bet.find(bet_id)).payout_determiner
    payout_object[:winner].each_with_index do |usr,idx|
      Bank.pay_to_account(bet_id,User.find(usr),payout_object[:amount][idx],payout_object[:money_type])
      Winning.create(user_id: usr, bet_id: bet_id, lolteam_id: payout_object[:lolteam_id],
                     amount: payout_object[:amount][idx],
                     real_money: payout_object[:money_type] == "fake_money" ? false : true
                    )
    end
  end

end
