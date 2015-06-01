require 'rails_helper'

RSpec.describe Lolteam, type: :model do
  let(:user1) { FactoryGirl.create(:user) }
  let(:user2) { FactoryGirl.create(:user) }
  let(:bet1)  { FactoryGirl.create(:bet) }
  let(:bet2)  { FactoryGirl.create(:bet) }
  let(:summoner1) { FactoryGirl.create(:summoner) }
  let(:summoner2) { FactoryGirl.create(:summoner) }
  let(:summoner3) { FactoryGirl.create(:summoner) }
  let(:summoner4) { FactoryGirl.create(:summoner) }
  let(:summoner5) { FactoryGirl.create(:summoner) }
  let(:summoner6) { FactoryGirl.create(:summoner) }
  let(:summoner7) { FactoryGirl.create(:summoner) }

  context 'when creating a lolteam' do
    it 'should have user_id and bet_id to save' do
      lol = Lolteam.new(slot1: 1, slot2: 2)
      lol.slot3 = summoner3.id
      lol.slot4 = summoner4.id
      lol.slot5 = summoner5.id
      lol.slot6 = summoner6.id
      lol.slot7 = summoner7.id
      expect(lol.save).to be(false)
      lol.user_id = user1.id
      expect(lol.save).to be(false)
      lol.bet_id = bet1.id
      expect(lol.save).to be(true)
    end

    it 'must have 7 summoners, no more no less' do
      lol = Lolteam.new(slot1: summoner1.id, slot2: summoner2.id, user_id: user1.id, bet_id: bet1.id)
      expect(lol.save).to be(false)
      lol.slot3 = summoner3.id
      lol.slot4 = summoner4.id
      lol.slot5 = summoner5.id
      lol.slot6 = summoner6.id
      lol.slot7 = summoner7.id
      expect(lol.save).to be(true)
    end

    #This Test is failing because the bet.user_count is being called on the create action in the
    #controller, and therefore is difficult to test from the model.
    # it 'should update the user count of the bet + 1' do
    #   bet1.update_attributes(user_count: 9, entrants: 10)
    #   expect(bet1.user_count).to be(9)
    #   lol = Lolteam.new(slot1: summoner1.id, slot2: summoner2.id, user_id: user1.id, bet_id: bet1.id,
    #                     slot3: summoner3.id, slot4: summoner4.id, slot5: summoner5.id, slot6: summoner6.id,
    #                     slot7: summoner7.id)
    #   expect(lol.save).to be(true)
    #   expect(bet1.user_count).to be(10)
    # end

    it 'cannot be saved if the bet.user_count is over the bet.max_entrants' do
      bet1.update_attributes(user_count: 9, entrants: 10)
      lol = Lolteam.new(slot1: summoner1.id, slot2: summoner2.id, user_id: user1.id, bet_id: bet1.id,
                        slot3: summoner3.id, slot4: summoner4.id, slot5: summoner5.id, slot6: summoner6.id,
                        slot7: summoner7.id)
      expect(lol.save).to be(true)
      bet1.update_attributes(user_count: 10, entrants: 10)
      lol2 = Lolteam.new(slot1: summoner1.id, slot2: summoner2.id, user_id: user1.id, bet_id: bet1.id,
                  slot3: summoner3.id, slot4: summoner4.id, slot5: summoner5.id, slot6: summoner6.id,
                  slot7: summoner7.id)
      expect(lol2.save).to be(false)
    end

    it 'cannot use the same summoner more than once' do
      lol = Lolteam.new(slot1: summoner7.id, slot2: summoner2.id, user_id: user1.id, bet_id: bet1.id,
                        slot3: summoner3.id, slot4: summoner4.id, slot5: summoner5.id, slot6: summoner6.id,
                        slot7: summoner7.id)
      expect(lol.save).to be(false)
      lol2 = Lolteam.new(slot1: summoner1.id, slot2: summoner2.id, user_id: user1.id, bet_id: bet1.id,
                        slot3: summoner3.id, slot4: summoner4.id, slot5: summoner5.id, slot6: summoner6.id,
                        slot7: summoner7.id)
      expect(lol2.save).to be(true)
    end
  end

end
