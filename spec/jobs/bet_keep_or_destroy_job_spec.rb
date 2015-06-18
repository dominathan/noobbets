require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe BetKeepOrDestroyJob, type: :job do
  let(:bet) { FactoryGirl.create(:bet) }
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:user3) { FactoryGirl.create(:user) }

  context 'queueing the job' do
    it 'should change the the number of jobs' do
      Sidekiq::Testing.fake!
      expect {
        BetKeepOrDestroyJob.perform_async(bet.id) }.to change(BetKeepOrDestroyJob.jobs, :size).by(1)
    end

    it 'should not change PayoutCalculatorJob count when bet.users < 2' do
      Sidekiq::Testing.fake!
      bet.bet_users.create(user_id: user1.id, bet_id: bet.id)
      bet.bet_users.create(user_id: user1.id, bet_id: bet.id)
      expect { BetKeepOrDestroyJob.new.perform(bet.id) }.to change( PayoutCalculatorJob.jobs, :size).by(0)
    end

    it 'should enqueue PayoutCalculatorJob when the bet.users.count > 2' do
      Sidekiq::Testing.fake!
      bet.bet_users.create(user_id: user1.id, bet_id: bet.id)
      bet.bet_users.create(user_id: user1.id, bet_id: bet.id)
      bet.bet_users.create(user_id: user1.id, bet_id: bet.id)
      expect { BetKeepOrDestroyJob.new.perform(bet.id) }.to change( PayoutCalculatorJob.jobs, :size).by(1)
    end
  end



end
