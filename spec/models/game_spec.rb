require 'json'
require 'rails_helper'

RSpec.describe Game, type: :model do
  let(:games_object) { JSON.parse(File.open('lib/assets/games.json').read) }
  let(:stubbed_game1) { games_object['games'].first }
  let(:stubbed_game2) { games_object['games'].last }

  let(:summoner1) { FactoryGirl.create(:summoner, id: 1) }
  let(:summoner2) { FactoryGirl.create(:summoner, id: 2) }

  context 'when saving a game' do

    it 'should require lol_game_id' do
      game = Game.new
      game.create_date = DateTime.now
      game.summoner_id = summoner1.id
      expect(game.save).to be(false)
      game.lol_game_id = 1
      expect(game.save).to be_truthy
    end

    it 'should require a createDate' do
      game = Game.new
      game.summoner_id = summoner1.id
      game.lol_game_id = 1
      expect(game.save).to be(false)
      game.create_date = DateTime.now
      expect(game.save).to be_truthy
    end

    it 'should require a valid summoner_id' do
      game = Game.new
      game.lol_game_id = 1
      game.create_date = DateTime.now
      expect(game.save).to be(false)
      game.summoner_id = summoner2.id
      expect(game.save).to be_truthy
    end
  end

  context 'when creating a game' do
    it 'should be correct from the data given' do
      game1 = Game.create_game(stubbed_game1,summoner1)

      expect(game1.num_deaths).to be(10)
      expect(game1.champions_killed).to be(7)
      expect(game1.win).to be(false)
      expect(game1.minions_killed).to be(202)
      expect(game1.create_date).equal?(DateTime.new(2015,4,6,2,34,38))
      expect(game1.assists).to be(5)
      expect(game1.total_damage_dealt).to be(140276)
      expect(game1.total_damage_taken).to be(21163)
      expect(game1.total_damage_dealt_to_champion).to be(17045)
      expect(game1.killing_sprees).to be(2)
      expect(game1.summoner_id).to be(summoner1.id)
      expect(game1.lol_game_id).to be(1785173998)
      expect(game1.barracks_killed).to be(0)
      expect(game1.combat_player_score).to be(0)
      expect(game1.consumables_purchased).to be(0)
      expect(game1.damage_dealt_player).to be(0)
      expect(game1.double_kills).to be(0)
      expect(game1.first_blood).to be(0)
      expect(game1.gold).to be(0)
      expect(game1.gold_earned).to be(11680)
      expect(game1.gold_spent).to be(11125)
      expect(game1.item0).to be(3020)
      expect(game1.item1).to be(3157)
      expect(game1.item2).to be(1026)
      expect(game1.item3).to be(3165)
      expect(game1.item4).to be(1056)
      expect(game1.item5).to be(3135)
      expect(game1.item6).to be(3340)
      expect(game1.items_purchased).to be(0)
      expect(game1.largest_critical_strike).to be(0)
      expect(game1.largest_killing_spree).to be(2)
      expect(game1.largest_multi_kill).to be(1)
      expect(game1.legendary_items_created).to be(0)
      expect(game1.level).to be(15)
      expect(game1.magic_damage_dealt_player).to be(126924)
      expect(game1.magic_damage_dealt_to_champions).to be(16182)
      expect(game1.magic_damage_taken).to be(11783)
      expect(game1.minions_denied).to be(0)
      expect(game1.neutral_minions_killed).to be(4)
      expect(game1.neutral_minions_killed_enemy_jungle).to be(0)
      expect(game1.neutral_minions_killed_your_jungle).to be(4)
      expect(game1.nexus_killed).to be(nil)
      expect(game1.node_capture).to be(0)
      expect(game1.node_neutralize_assist).to be(0)
      expect(game1.num_items_bought).to be(0)
      expect(game1.objective_player_score).to be(0)
      expect(game1.penta_kills).to be(0)
      expect(game1.physical_damage_dealt_player).to be(13012)
      expect(game1.physical_damage_dealt_to_champions).to be(523)
      expect(game1.physical_damage_taken).to be(9031)
      expect(game1.player_position).to be(2)
      expect(game1.player_role).to be(4)
      expect(game1.quadra_kills).to be(0)
      expect(game1.sight_wards_bought).to be(7)
      expect(game1.spell_1_cast).to be(0)
      expect(game1.spell_2_cast).to be(0)
      expect(game1.spell_3_cast).to be(0)
      expect(game1.spell_4_cast).to be(0)
      expect(game1.summon_spell_1_cast).to be(0)
      expect(game1.summon_spell_2_cast).to be(0)
      expect(game1.super_monster_killed).to be(0)
      expect(game1.team).to be(100)
      expect(game1.team_objective).to be(0)
      expect(game1.time_played).to be(2084)
      expect(game1.total_heal).to be(796)
      expect(game1.total_player_score).to be(0)
      expect(game1.total_score_rank).to be(0)
      expect(game1.total_time_crowd_control_dealt).to be(344)
      expect(game1.total_units_healed).to be(1)
      expect(game1.triple_kills).to be(0)
      expect(game1.true_damage_dealt_player).to be(340)
      expect(game1.true_damage_dealt_to_champions).to be(340)
      expect(game1.true_damage_taken).to be(348)
      expect(game1.turrets_killed).to be(1)
      expect(game1.unreal_kills).to be(0)
      expect(game1.victory_point_total).to be(0)
      expect(game1.vision_wards_bought).to be(1)
      expect(game1.ward_killed).to be(4)
      expect(game1.ward_placed).to be(18)
    end

    it 'should also be correct from the data given' do
      game2 = Game.create_game(stubbed_game2,summoner2)

      expect(game2.num_deaths).to be(12)
      expect(game2.champions_killed).to be(31)
      expect(game2.win).to be(false)
      expect(game2.minions_killed).to be(151)
      expect(game2.create_date).equal?(DateTime.new(2015,4,6,2,34,38))
      expect(game2.assists).to be(7)
      expect(game2.total_damage_dealt).to be(185122)
      expect(game2.total_damage_taken).to be(28558)
      expect(game2.total_damage_dealt_to_champion).to be(54619)
      expect(game2.killing_sprees).to be(4)
      expect(game2.summoner_id).to be(summoner2.id)
      expect(game2.lol_game_id).to be(1784270998)
      expect(game2.barracks_killed).to be(0)
      expect(game2.combat_player_score).to be(0)
      expect(game2.consumables_purchased).to be(0)
      expect(game2.damage_dealt_player).to be(0)
      expect(game2.double_kills).to be(9)
      expect(game2.first_blood).to be(0)
      expect(game2.gold).to be(0)
      expect(game2.gold_earned).to be(21600)
      expect(game2.gold_spent).to be(18305)
      expect(game2.item0).to be(3135)
      expect(game2.item1).to be(3157)
      expect(game2.item2).to be(3255)
      expect(game2.item3).to be(3100)
      expect(game2.item4).to be(3089)
      expect(game2.item5).to be(3285)
      expect(game2.item6).to be(3362)
      expect(game2.items_purchased).to be(0)
      expect(game2.largest_critical_strike).to be(0)
      expect(game2.largest_killing_spree).to be(10)
      expect(game2.largest_multi_kill).to be(3)
      expect(game2.legendary_items_created).to be(0)
      expect(game2.level).to be(20)
      expect(game2.magic_damage_dealt_player).to be(154947)
      expect(game2.magic_damage_dealt_to_champions).to be(46928)
      expect(game2.magic_damage_taken).to be(18640)
      expect(game2.minions_denied).to be(0)
      expect(game2.neutral_minions_killed).to be(6)
      expect(game2.neutral_minions_killed_enemy_jungle).to be(3)
      expect(game2.neutral_minions_killed_your_jungle).to be(3)
      expect(game2.nexus_killed).to be(nil)
      expect(game2.node_capture).to be(0)
      expect(game2.node_neutralize_assist).to be(0)
      expect(game2.num_items_bought).to be(0)
      expect(game2.objective_player_score).to be(0)
      expect(game2.penta_kills).to be(0)
      expect(game2.physical_damage_dealt_player).to be(29533)
      expect(game2.physical_damage_dealt_to_champions).to be(7254)
      expect(game2.physical_damage_taken).to be(7361)
      expect(game2.player_position).to be(1)
      expect(game2.player_role).to be(1)
      expect(game2.quadra_kills).to be(0)
      expect(game2.sight_wards_bought).to be(1)
      expect(game2.spell_1_cast).to be(0)
      expect(game2.spell_2_cast).to be(0)
      expect(game2.spell_3_cast).to be(0)
      expect(game2.spell_4_cast).to be(0)
      expect(game2.summon_spell_1_cast).to be(0)
      expect(game2.summon_spell_2_cast).to be(0)
      expect(game2.super_monster_killed).to be(0)
      expect(game2.team).to be(100)
      expect(game2.team_objective).to be(0)
      expect(game2.time_played).to be(1392)
      expect(game2.total_heal).to be(2791)
      expect(game2.total_player_score).to be(0)
      expect(game2.total_score_rank).to be(0)
      expect(game2.total_time_crowd_control_dealt).to be(75)
      expect(game2.total_units_healed).to be(1)
      expect(game2.triple_kills).to be(3)
      expect(game2.true_damage_dealt_player).to be(641)
      expect(game2.true_damage_dealt_to_champions).to be(436)
      expect(game2.true_damage_taken).to be(2555)
      expect(game2.turrets_killed).to be(2)
      expect(game2.unreal_kills).to be(0)
      expect(game2.victory_point_total).to be(0)
      expect(game2.vision_wards_bought).to be(0)
      expect(game2.ward_killed).to be(1)
      expect(game2.ward_placed).to be(6)
    end

  end
end
