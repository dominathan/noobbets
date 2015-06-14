require 'open-uri'
require 'uri'
require 'json'
require 'rails_helper'
RSpec.describe 'GetRiotAPI' do
  context 'grabbing summoner information' do

    it 'should respond with this format' do
      VCR.use_cassette('fatetwisted summoner') do
        expect(GetRiotAPI.summoner_information('Fate Twisted')).to match(
          { "fatetwisted"=>{"id"=>65550074, "name"=>"Fate Twisted", "profileIconId"=>666, "summonerLevel"=>30, "revisionDate"=>1434234241000} }
        )
      end
    end

    it 'should accept multiple names concatenated with commas' do
      VCR.use_cassette('multiple summoners') do
        expect(GetRiotAPI.summoner_information("Fate Twisted,Summer Sparkle,Fuszion,A Wild AP Sona,grazer,Guardian Janna")).to match(
          {"summersparkle"=>{"id"=>60004918, "name"=>"Summer Sparkle", "profileIconId"=>14, "summonerLevel"=>30, "revisionDate"=>1434090852000}, "fatetwisted"=>{"id"=>65550074, "name"=>"Fate Twisted", "profileIconId"=>666, "summonerLevel"=>30, "revisionDate"=>1434234241000}, "guardianjanna"=>{"id"=>41215093, "name"=>"Guardian Janna", "profileIconId"=>21, "summonerLevel"=>30, "revisionDate"=>1434240638000}, "awildapsona"=>{"id"=>47540501, "name"=>"A Wild AP Sona", "profileIconId"=>642, "summonerLevel"=>30, "revisionDate"=>1434225217000}, "fuszion"=>{"id"=>19240416, "name"=>"Fuszion", "profileIconId"=>783, "summonerLevel"=>30, "revisionDate"=>1434167908000}, "grazer"=>{"id"=>21186676, "name"=>"grazer", "profileIconId"=>22, "summonerLevel"=>30, "revisionDate"=>1433394442000}}
        )
      end
    end
  end

  context 'grabbing summoner game information' do
    it 'should grab 10 most recent games of summoner' do
      VCR.use_cassette('fuszion recent games') do
        response = GetRiotAPI.recent_games(19240416)
        expect(response['games'].length).to eq(10)
        expect(response['summonerId']).to eq(19240416)
      end
    end
  end
end
