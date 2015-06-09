class Bank < ActiveRecord::Base
  belongs_to :bet
  belongs_to :user

  validates_presence_of :bet_id, :user_id, :amount
  before_save :amount_is_equal_to_bet_cost?

    def self.create_and_account(bet,user,amount)
      Bank.create(bet_id: bet.id, user_id: user.id, amount: bet.cost)
      oldval = user.fake_money
      user.update_attribute(:fake_money, (oldval - bet.cost) )
    end

  private

    def amount_is_equal_to_bet_cost?
      self.amount == self.bet.cost
    end



end
