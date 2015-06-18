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
    bet.reward
  end

  def amount_due_to_noobbets
    ( bet.reward / ( 1 - noobbet_rake_percentage ) ) * noobbet_rake_percentage
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
      sorted_winning_objects = sorted_users_by_score
      users = sorted_winning_objects.first[:user_id]
      lolteam_id = sorted_winning_objects.first[:lolteam_id]
      amount_to_user = amount_due_to_users
      amount_to_noobbet = amount_due_to_noobbets
      {
        winner: [users], amount: [amount_to_user], noobbet: amount_to_noobbet,
        money_type: "fake_money", lolteam_ids: [lolteam_id]
      }
    end

    def top_three_fake
      sorted_winning_objects = sorted_users_by_score
      users = sorted_winning_objects[0..2].map { |obj| obj[:user_id] }
      lolteam_ids = sorted_winning_objects[0..2].map { |obj| obj[:lolteam_id] }
      cached_amount_due_to_users = amount_due_to_users
      amounts = top_three_payout.map { |amt| (cached_amount_due_to_users * amt).round }
      amount_to_noobbet = amount_due_to_noobbets
      {
        winner: users, amount: amounts, noobbet: amount_to_noobbet,
        money_type: "fake_money", lolteam_ids: lolteam_ids
      }
    end

    def top_half_fake
      sorted_winning_objects = sorted_users_by_score
      all_users = sorted_winning_objects.map { |obj| obj[:user_id] }
      all_lolteam_ids = sorted_winning_objects.map { |obj| obj[:lolteam_id] }
      top_half_of_users = all_users[0..(all_users.length/2 - 1)]
      top_half_of_lolteams = all_lolteam_ids[0..(all_lolteam_ids.length/2 - 1)]
      amount_to_users = (bet.cost + ( bet.cost * (1 - noobbet_rake_percentage) )).round(0)
      amounts = Array.new(top_half_of_users.length,amount_to_users)
      amount_to_noobbet = amount_due_to_noobbets
      {
        winner: top_half_of_users, amount: amounts, noobbet: amount_to_noobbet,
        money_type: "fake_money", lolteam_ids: top_half_of_lolteams
      }
    end
end
