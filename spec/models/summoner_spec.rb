require 'rails_helper'

RSpec.describe Summoner, type: :model do
  let(:summoner1) { FactoryGirl.create(:summoner) }
  let(:summoner2) { FactoryGirl.create(:summoner) }

  context 'when saving a new summoner' do
    it 'must have a name' do
      summoner = Summoner.new
      summoner.lol_id = 32
      expect(summoner.save).to be(false)
      summoner.name = "HELLO!"
      expect(summoner.save).to be(true)
    end

    it 'must have lol_id' do
      summoner = Summoner.new
      summoner.name = "HELLO"
      expect(summoner.save).to be(false)
      summoner.lol_id = 34
      expect(summoner.save).to be(true)
    end

    it 'must have a uniq lol id' do
      summoner = Summoner.new
      summoner.name = "HELLO"
      summoner.lol_id = summoner1.lol_id
      expect(summoner.save).to be(false)
      summoner.lol_id = 33
      expect(summoner.save).to be(true)
    end
  end
end
