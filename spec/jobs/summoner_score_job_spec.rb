require 'rails_helper'

RSpec.describe SummonerScoreJob, type: :job do
  let(:summoner1) {FactoryGirl.create(:summoner) }
  let(:summoner2) {FactoryGirl.create(:summoner) }
  context 'queueing the job' do
    it 'should change the the number of jobs' do
      Sidekiq::Testing.fake!
      expect {
        SummonerScoreJob.perform_async }.to change(
          SummonerScoreJob.jobs, :size).by(1)
    end
  end

end
