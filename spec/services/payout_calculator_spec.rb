require 'rails_helper'

RSpec.describe 'PayoutCalculator' do
  let(:bet1) { FactoryGirl.create(:bet) }
  subject { PayoutCalculator.new(bet1) }

  context 'when passing parameters' do
    it 'should initialize with the bet' do
      expect(subject.bet.bet_type).to match('Winner Take All')
    end

    it 'should have noobbet_rake_percentage of 10%' do
      expect(subject.noobbet_rake_percentage).to eq(0.1)
    end

    it 'should have a payout_determiner that picks the payout method' do
      expect(subject).to respond_to(:payout_determiner)
      expect(subject.payout_determiner).to call(:winner_take_all_fake)
    end

  end

end
