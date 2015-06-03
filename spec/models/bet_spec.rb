require 'rails_helper'

RSpec.describe Bet, type: :model do

  let(:factory_bet) { FactoryGirl.create(:bet) }

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


end
