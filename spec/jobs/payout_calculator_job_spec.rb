require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe PayoutCalculatorJob, type: :job do

  let(:bet) {FactoryGirl.create(:bet) }
  let(:user) { FactoryGirl.create(:user) }
  let(:lolteam) { FactoryGirl.create(:lolteam, user_id: user.id, bet_id: bet.id) }
  context 'queueing the job' do
    it 'should change the the number of jobs' do
      Sidekiq::Testing.fake!
      expect {
        PayoutCalculatorJob.perform_async(bet.id) }.to change(
          PayoutCalculatorJob.jobs, :size).by(1)
    end

    it 'should perform 4 hours later do' do
      Sidekiq::Testing.inline!
      expect(PayoutCalculatorJob).to receive(:perform_in).with(4.hours, bet.id)
      PayoutCalculatorJob.perform_in(4.hours,bet.id)
    end
  end
end
