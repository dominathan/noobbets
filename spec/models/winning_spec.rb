require 'rails_helper'

RSpec.describe Winning, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:bet) { FactoryGirl.create(:bet) }
  let(:lolteam) { FactoryGirl.create(:lolteam) }

  context 'when creating a bet' do
    it 'should require user_id, bet_id, lolteam_id' do
      win = Winning.new(amount: 100, real_money: false)

      expect(win.save).to be(false)
      win.user_id = user.id
      expect(win.save).to be(false)
      win.bet_id = bet.id
      expect(win.save).to be(false)
      win.lolteam_id = lolteam.id
      expect(win.save).to be(true)
    end

    it 'should require an amount thats not nil' do
      win = Winning.new(user_id: user.id, bet_id: bet.id, lolteam_id: lolteam.id)
      expect(win.save).to be(false)
      win.amount = 100
      # expect(win.save).to be(false)
      win.real_money = false
      expect(win.save).to be(true)
    end
  end
end
