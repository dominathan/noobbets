class Bank < ActiveRecord::Base
  belongs_to :bet
  belongs_to :user

  validates_presence_of :bet_id, :user_id, :amount

  before_create :amount_is_equal_to_bet_cost?

  def self.create_and_account(bet,user,amount)
    Bank.create!(bet_id: bet.id, user_id: user.id, amount: bet.cost)
    oldval = user.fake_money
    user.update_attribute(:fake_money, (oldval - bet.cost) )
  end

  def self.pay_to_account(bet,user,amount,money_type)
    user_old_amount = user.send(money_type.to_sym)
    user.update_attribute(money_type.to_sym, (user_old_amount+amount))
  end

  private

    def amount_is_equal_to_bet_cost?
      self.amount == self.bet.cost
    end
end

