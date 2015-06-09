require 'rails_helper'

RSpec.describe Bet, type: :model do

  let(:factory_bet) { FactoryGirl.create(:bet) }
  let(:user) { FactoryGirl.create(:user) }

  context 'when creating a new bet' do
    it 'should require all attribtues' do
      bet = Bet.new
      bet.completed = false
      bet.start_time = DateTime.now + 2.days
      bet.end_time = DateTime.now + 1.week
      bet.entrants = 10
      expect(bet.save).to be(false)
      bet.cost = 1000
      expect(bet.save).to be(false)
      bet.bet_type = "winner_take_all"
      expect(bet.save).to be(true)
    end

    it 'should have start_time that begins before the end_time' do
      bet = Bet.new(entrants: 10, completed: false, bet_type: "winner",
                    cost: 1000, start_time: DateTime.now, end_time: DateTime.now - 1.week)
      expect(bet.save).to be(false)
      bet.end_time = bet.start_time
      expect(bet.save).to be(false)
      bet.end_time = DateTime.now + 1.week
      expect(bet.save).to be(true)
    end

    it 'should begin with completed == false' do
      expect(factory_bet.completed).to be(false)
    end
  end

  context 'when checking the bet users and bank' do
    it 'should have users through bet_users' do
      expect(factory_bet.users).to_not be_nil
      factory_bet.bet_users.create!(user_id: user.id)
      expect(factory_bet.users.count).to be(1)
    end

    it 'should be able to access its bank' do
      expect(factory_bet.banks).to_not be_nil
    end

    it 'should have money in the bank if users count > 0' do
      factory_bet.bet_users.create!(user_id: user.id)
      Bank.create_and_account(factory_bet, user, factory_bet.cost)
      expect(factory_bet.banks.count).to be(1)
      expect(factory_bet.banks.sum(:amount)).to be(1000)
    end
  end

end
