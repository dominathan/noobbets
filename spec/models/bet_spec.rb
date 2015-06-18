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
      expect(bet.save).to be(false)
      bet.reward = (bet.cost * bet.entrants) * (1 - Bet::NOOBBET_RAKE_PERCENTAGE)
      expect(bet.save).to be(true)
    end

    it 'should have start_time that begins before the end_time' do
      bet = Bet.new(entrants: 10, completed: false, bet_type: "winner",
                    cost: 1000, start_time: DateTime.now, end_time: DateTime.now - 1.week, reward: 9000)
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

  context 'noobbet_rake_percentage' do
    it 'should equal 10%' do
      expect(Bet::NOOBBET_RAKE_PERCENTAGE).to eq(0.1)
    end

    it "should be the same as payoutcalculator's NOOBBET_RAKE_PERCENTAGE" do
      payt = PayoutCalculator.new(factory_bet).noobbet_rake_percentage
      expect(Bet::NOOBBET_RAKE_PERCENTAGE).to eq(payt)
    end
  end

  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }
  let(:user4) { FactoryGirl.create(:user) }
  let(:user5) { FactoryGirl.create(:user) }
  let(:user6) { FactoryGirl.create(:user) }
  let(:user7) { FactoryGirl.create(:user) }
  let(:scoring_bet) { FactoryGirl.create(:bet) }
  let(:lolteam1) { FactoryGirl.create(:lolteam, user_id: user1.id, bet_id: scoring_bet.id) }
  let(:lolteam2) { FactoryGirl.create(:lolteam, user_id: user2.id, bet_id: scoring_bet.id) }
  let(:lolteam3) { FactoryGirl.create(:lolteam, user_id: user3.id, bet_id: scoring_bet.id) }
  let(:lolteam4) { FactoryGirl.create(:lolteam, user_id: user4.id, bet_id: scoring_bet.id) }
  let(:lolteam5) { FactoryGirl.create(:lolteam, user_id: user5.id, bet_id: scoring_bet.id) }
  let(:lolteam6) { FactoryGirl.create(:lolteam, user_id: user6.id, bet_id: scoring_bet.id) }
  let(:lolteam7) { FactoryGirl.create(:lolteam, user_id: user7.id, bet_id: scoring_bet.id) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 1) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 2) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 3) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 4) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 5) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 6) }
  let(:game) {FactoryGirl.create(:game, summoner_id: 7) }

  context 'when scoring the bet' do
    it 'should be able to sort users by their lolteam_score' do
      lolteam4.should_receive(:score_user_lolteam).and_return( {'total_score' => 4000, 'user_id' => user4.id } )
      lolteam7.should_receive(:score_user_lolteam).and_return( {'total_score' => 7000, 'user_id' => user7.id } )
      lolteam6.should_receive(:score_user_lolteam).and_return( {'total_score' => 6000, 'user_id' => user6.id } )
      lolteam3.should_receive(:score_user_lolteam).and_return( {'total_score' => 3000, 'user_id' => user3.id } )
      lolteam5.should_receive(:score_user_lolteam).and_return( {'total_score' => 5000, 'user_id' => user5.id } )
      lolteam1.should_receive(:score_user_lolteam).and_return( {'total_score' => 1000, 'user_id' => user1.id } )
      lolteam2.should_receive(:score_user_lolteam).and_return( {'total_score' => 2000, 'user_id' => user2.id } )
      lolteam4.score_user_lolteam
      lolteam7.score_user_lolteam
      lolteam6.score_user_lolteam
      lolteam3.score_user_lolteam
      lolteam5.score_user_lolteam
      lolteam1.score_user_lolteam
      lolteam2.score_user_lolteam

      scoring_bet.lolteams[0].should_receive(:score_user_lolteam).and_return( {'total_score' => 4000, 'user_id' => user4.id } )
      scoring_bet.lolteams[1].should_receive(:score_user_lolteam).and_return( {'total_score' => 7000, 'user_id' => user7.id } )
      scoring_bet.lolteams[2].should_receive(:score_user_lolteam).and_return( {'total_score' => 6000, 'user_id' => user6.id } )
      scoring_bet.lolteams[3].should_receive(:score_user_lolteam).and_return( {'total_score' => 3000, 'user_id' => user3.id } )
      scoring_bet.lolteams[4].should_receive(:score_user_lolteam).and_return( {'total_score' => 5000, 'user_id' => user5.id } )
      scoring_bet.lolteams[5].should_receive(:score_user_lolteam).and_return( {'total_score' => 1000, 'user_id' => user1.id } )
      scoring_bet.lolteams[6].should_receive(:score_user_lolteam).and_return( {'total_score' => 2000, 'user_id' => user2.id } )
      expect(scoring_bet).to respond_to(:sort_users_by_highest_total_score)
      expect(scoring_bet.sort_users_by_highest_total_score).to match([{ 'total_score' => 7000, 'user_id' => user7.id },
                                                                      { 'total_score' => 6000, 'user_id' => user6.id },
                                                                      { 'total_score' => 5000, 'user_id' => user5.id },
                                                                      { 'total_score' => 4000, 'user_id' => user4.id },
                                                                      { 'total_score' => 3000, 'user_id' => user3.id },
                                                                      { 'total_score' => 2000, 'user_id' => user2.id },
                                                                      { 'total_score' => 1000, 'user_id' => user1.id }])
    end
  end

  context 'when calling keep_or_destroy' do
    before :each do
      user10 =  FactoryGirl.create(:user)
      user11 = FactoryGirl.create(:user)
      factory_bet.bet_users.create!(user_id: user10.id, bet_id: factory_bet.id)
      factory_bet.bet_users.create!(user_id: user11.id, bet_id: factory_bet.id)
    end

    it 'should destroy the bet with 2 or less users' do
      Bet.keep_or_destroy(factory_bet.id)
      expect(Bet.find_by(id: factory_bet.id)).to be(nil)
    end

    it 'should not destroy bets with 3 or more users' do
      user12 = FactoryGirl.create(:user)
      factory_bet.bet_users.create!(user_id: user12.id, bet_id: factory_bet.id)
      Bet.keep_or_destroy(factory_bet.id)
      expect(Bet.find_by(id: factory_bet.id)).to eq(factory_bet)
    end
  end

end
