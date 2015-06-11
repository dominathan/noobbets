class PayoutCalculator

  attr_reader :bet
  def initialize(bet)
    @bet = bet
  end

  def noobbet_rake_percentage
    0.1
  end

  def payout_determiner
    case bet.bet_type
    when "Winner Take All"
      winner_take_all_fake
    when 'Top Half'
      top_half_fake
    when "Top 3"
      top_three_fake
    end
  end

  private
    def winner_take_all_fake
      user = bet.sort_users_by_highest_total_score.first
      amount_to_user = bet.banks.sum(:amount)*( 1 - noobbet_rake_percentage )
      Bank.pay_to_account(bet,user,amount_to_user,'fake_money')
      amount_to_bank = bet.banks.sum(:amount)*( noobbet_rake_percentage )
      ##expect(amount_to_user + amount_to_bank == bet.banks.sum(:amount))
    end
end
