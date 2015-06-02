require 'rails_helper'

RSpec.describe Summoner, type: :model do
  let(:summoner1) { FactoryGirl.create(:summoner) }
  let(:summoner2) { FactoryGirl.create(:summoner) }
  let(:bet1) { FactoryGirl.create(:bet, start_time: DateTime.now - 3.years,
                                        end_time: DateTime.now + 3.years)}
  let(:bet2) { FactoryGirl.create(:bet, start_time: DateTime.new(2015,4,6,2,34,38) - 1.minutes,
                                        end_time: DateTime.new(2015,4,6,2,34,38) + 1.minutes)}
  let(:user1) { FactoryGirl.create(:user) }
  let(:games) { JSON.parse(File.open('lib/assets/games.json').read) }

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

  context 'when scoring a summoner' do

    it 'should have the scoring_categories correct' do
      expect(summoner1.scoring_categories).to match(['champions_killed','num_deaths','assists','minions_killed','triple_kills',
      'quadra_kills','penta_kills','first_blood','win'])
    end

      # 2 points per kill
      # -0.5 points per death
      # 1.5 points per assist
      # 0.01 points per creep kill
      # 2 points for a triple kill
      # 5 points for a quadra kill (doesn't also count as a triple kill)
      # 10 points for a penta kill (doesn't also count as a quadra kill)
      # 2 points if a player attains 10 or more assists or kills in a game (this bonus only applies once)
      # 3 points for first blood
      # 3 points for win

    it 'should have the scoring values correct' do
      expect(summoner1.scoring_values).to match([2.0,-0.5,1.5,0.01,2.0,5.0,10.0,3,3])
    end

  # For all 10 games of the parsed file, the stats are.
    # numDeaths: 52
    # championsKilled: 88
    # assists: 114
    # minionKilled: 1912
    # tripleKills: 4
    # quadraKills: 0
    # pentaKills: 0
    # firstBlood: 0
    # win: 5
    it 'should respond to and correctly value a column with score_summoner_games_over_bet_timeframe(bet_id,desired_attribute)' do
      Game.create_all_games(games,summoner1)
      expect(summoner1.games.count).to eq(10)
      expect(summoner1.score_summoner_games_over_bet_timeframe(bet1.id,'assists')).to eq(114)
      expect(summoner1.score_summoner_games_over_bet_timeframe(bet1.id,'minions_killed')).to eq(1912)
      expect(summoner1.score_summoner_games_over_bet_timeframe(bet1.id,'win')).to eq(5)
    end

    it 'array_of_scored_categories should return all total column sums' do
      Game.create_all_games(games,summoner1)
      expect(summoner1.array_of_scored_attributes(bet1.id)).to eq([88,52,114,1912,4,0,0,0,5])
    end

    it 'final_score should be correctly computed' do
      Game.create_all_games(games,summoner1)
      expect(summoner1.final_score(bet1.id)).to eq(363.12)
    end

    it 'final_score should take into account the date the bet starts and ends' do
      Game.create_all_games(games,summoner1)
      expect(summoner1.final_score(bet2.id)).to eq(18.52)
    end
  end

end
