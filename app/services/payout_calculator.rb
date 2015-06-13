class PayoutCalculator

  attr_reader :bet
  def initialize(bet)
    @bet = bet
  end

  def noobbet_rake_percentage
    0.1
  end

  def top_three_payout
    [0.6,0.3,0.1]
  end

  def amount_due_to_users
    (bet.banks.sum(:amount) * ( 1 - noobbet_rake_percentage )).round
  end

  def amount_due_to_noobbets
    (bet.banks.sum(:amount) * ( noobbet_rake_percentage )).round
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

  def sorted_users_by_score
    self.bet.sort_users_by_highest_total_score
  end

  private

    def winner_take_all_fake
      users = sorted_users_by_score.first[:user_id]
      amount_to_user = amount_due_to_users
      amount_to_noobbet = amount_due_to_noobbets
      { winner: [users], amount: [amount_to_user], noobbet: amount_to_noobbet, money_type: "fake_money" }
    end

    def top_three_fake
      users = sorted_users_by_score[0..2].map { |obj| obj[:user_id] }
      cached_amount_due_to_users = amount_due_to_users
      amounts = top_three_payout.map { |amt| (cached_amount_due_to_users * amt).round }
      amount_to_noobbet = amount_due_to_noobbets
      { winner: users, amount: amounts, noobbet: amount_to_noobbet, money_type: "fake_money" }
    end

    def top_half_fake
      all_users = sorted_users_by_score.map { |obj| obj[:user_id] }
      top_half_of_users = all_users[0..(all_users.length/2 - 1)]
      total_bank = amount_due_to_users
      avg = (1..top_half_of_users.length).reduce(&:+) * 1.0
      weighted_avg = top_half_of_users.map.with_index do |usr,idx|
        (( (idx + 1) * total_bank) / avg).round
      end
      top_amount_first = weighted_avg.reverse
      amount_to_noobbet = amount_due_to_noobbets
      { winner: top_half_of_users, amount: top_amount_first, noobbet: amount_to_noobbet, money_type: "fake_money"}
    end
end
