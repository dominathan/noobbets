require 'rails_helper'

RSpec.describe Bank, type: :model do
  let(:factory_bet) { FactoryGirl.create(:bet) }
  let(:user) { FactoryGirl.create(:user) }
  let(:user1) { FactoryGirl.create(:user1) }
  let(:user2) { FactoryGirl.create(:user, fake_money: 100) }
  let(:bet2) { FactoryGirl.create(:bet, entrants: 3, cost: 10) }
  context 'when the bank is created' do
    it 'the bank object should be created with user_id, bet_id, and bet.cost' do
      bank = Bank.new(bet_id: nil, user_id: nil, amount: nil)
      expect(bank.save).to be(false)
      bank.bet_id = factory_bet.id
      expect(bank.save).to be(false)
      bank.user_id = user.id
      expect(bank.save).to be(false)
      bank.amount = factory_bet.cost
      expect(bank.save).to be(true)
      expect(bank.amount).to be(1000)
    end

    it 'should have the bank.amount as the cost of the bet' do
      bank = Bank.new(bet_id: factory_bet.id, user_id: user.id, amount: 1)
      expect(bank.save).to be(false)
    end

    #This should be in bet, if Bet.bank.sum(:amount) < Bet.max_entrants * cost @start_time - cancel bet.
    it 'should sum the bank.amount with the same bet_id to bet.max_entrants * cost' do

    end

    it 'should have a Bank.create_and_account method that deducts from user and adds to self' do
      user2.update_attribute(:fake_money, 100)
      expect(Bank.create_and_account(bet2, user2, bet2.cost)).to be(true)
      bank = Bank.find_by(bet_id: bet2.id, user_id: user2.id)
      expect(bank).to_not be_nil
      expect(bank.user_id).to be(user2.id)
      expect(bank.bet_id).to be(bet2.id)
      expect(bank.amount).to be(bet2.cost)
      expect(user2.fake_money).to be(90)
    end
  end

end
