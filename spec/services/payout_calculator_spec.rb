require 'rails_helper'

RSpec.describe 'PayoutCalculator' do
  let(:bet1) { FactoryGirl.create(:bet, cost: 10, entrants: 5, reward: 45) }
  subject { PayoutCalculator.new(bet1) }

  context 'when passing parameters' do
    it 'should initialize with the bet' do
      expect(subject.bet.bet_type).to match('Winner Take All')
    end

    it 'should have noobbet_rake_percentage of 10%' do
      expect(subject.noobbet_rake_percentage).to eq(0.1)
    end

    it 'should have top_three_payout' do
      expect(subject.top_three_payout).to eq([0.6,0.3,0.1])
      expect(subject.top_three_payout.reduce(&:+).round(1)).to eq(1.0)
    end

    it 'should have a payout_determiner that picks the payout method' do
      expect(subject).to respond_to(:payout_determiner)
    end
  end

  let(:user1) { FactoryGirl.create(:user, email: 'testtesttest@test.com', username: "testtesttest",password: 'password', password_confirmation: 'password',fake_money: 40000) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:user4) { FactoryGirl.create(:user) }
  let(:user5) { FactoryGirl.create(:user) }

  context 'when determing a winner' do
    before :each do
      bank1 = Bank.create!(bet_id: bet1.id, user_id: user1.id, amount: 10)
      bank2 = Bank.create!(bet_id: bet1.id, user_id: user2.id, amount: 10)
      bank3 = Bank.create!(bet_id: bet1.id, user_id: user3.id, amount: 10)
      bank4 = Bank.create!(bet_id: bet1.id, user_id: user4.id, amount: 10)
      bank5 = Bank.create!(bet_id: bet1.id, user_id: user5.id, amount: 10)
    end
    it 'amount_due_to_users should equal the bet.banks sum - bet.banks sum * noobbet_rake_percentage' do
      expect(subject.amount_due_to_users).to eq(45)
    end

    it 'amount_due_to_noobbets should equal bet.banks sum * noobbet_rake_percentage' do
      expect(subject.amount_due_to_noobbets).to eq(5)
    end

    it 'amount to noobbets + amounts to users == bet.banks.sum(:amount)' do
      expect(subject.amount_due_to_users + subject.amount_due_to_noobbets).to eq(50)
    end
  end

  context 'when performing a payout' do

    before :each do
      bank1 = Bank.create!(bet_id: bet1.id, user_id: user1.id, amount: 10)
      bank2 = Bank.create!(bet_id: bet1.id, user_id: user2.id, amount: 10)
      bank3 = Bank.create!(bet_id: bet1.id, user_id: user3.id, amount: 10)
      bank4 = Bank.create!(bet_id: bet1.id, user_id: user4.id, amount: 10)
      bank5 = Bank.create!(bet_id: bet1.id, user_id: user5.id, amount: 10)
      subject.should_receive(:sorted_users_by_score).and_return( [{ user_id: user1.id, lolteam_id: 1},
                                                                { user_id: user5.id, lolteam_id: 5 },
                                                                { user_id: user3.id, lolteam_id: 3 },
                                                                { user_id: user4.id, lolteam_id: 4 },
                                                                { user_id: user2.id, lolteam_id: 2 }]
                                                              )
    end

    it 'gives 90% of winnings to the top player if bet-type = Winner Take All' do
      expect(subject.payout_determiner).to match({winner: [user1.id],
                                                   amount: [45],
                                                   noobbet: 5,
                                                   money_type: "fake_money",
                                                   lolteam_ids: [1]}
                                                   )
    end

    it 'gives 60%, 30% and 10% to top 3 players if bet-type = Top 3' do
      bet1.update_attribute(:bet_type, "Top 3")
      expect(subject.payout_determiner).to match({ winner: [user1.id,
                                                            user5.id,
                                                            user3.id],
                                                   amount: [27,14,5],
                                                   noobbet: 5,
                                                   money_type: "fake_money",
                                                   lolteam_ids: [1,5,3] })
    end

    it 'gives top 50% players the same amount (buyin + 90% buyin) if bet-type = "Top Half"' do
      bet1.update_attribute(:bet_type, "Top Half")
      expect(subject.payout_determiner).to match({ winner: [user1.id,user5.id ],
                                                   amount: [19,19],
                                                   noobbet: 5,
                                                   money_type: "fake_money",
                                                   lolteam_ids: [1,5] })
    end
  end

end
