# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
WebMock.allow_net_connect!
GetRiotAPI.get_summoner_ids(GetTopSummoners.get_from_lolking(2))
GetRiotAPI.get_recent_summoner_games

User.create(email: 'test@test.com', password: 'password', password_confirmation: 'password', username: "dominathan", fake_money: 40000)
User.create(email: 'test1@test.com', password: 'password', password_confirmation: 'password', username: "dominathan1", fake_money: 40000)
User.create(email: 'test2@test.com', password: 'password', password_confirmation: 'password', username: "dominathan2", fake_money: 40000)
User.create(email: 'test3@test.com', password: 'password', password_confirmation: 'password', username: "dominathan3", fake_money: 40000)
User.create(email: 'test4@test.com', password: 'password', password_confirmation: 'password', username: "dominathan4", fake_money: 40000)
User.create(email: 'test5@test.com', password: 'password', password_confirmation: 'password', username: "dominathan5", fake_money: 40000)
User.create(email: 'test6@test.com', password: 'password', password_confirmation: 'password', username: "dominathan6", fake_money: 40000)
User.create(email: 'test7@test.com', password: 'password', password_confirmation: 'password', username: "dominathan7", fake_money: 40000)
User.create(email: 'test8@test.com', password: 'password', password_confirmation: 'password', username: "dominathan8", fake_money: 40000)
User.create(email: 'test9@test.com', password: 'password', password_confirmation: 'password', username: "dominathan9", fake_money: 40000)

30.times do |n|
    cost = [100,200,500,1000,2000,5000,10000][Random.rand(0..6)]
    entrants = Random.rand(1..10)*10
    reward = (cost * entrants) * ( 1 - Bet::NOOBBET_RAKE_PERCENTAGE )
    end_time = [24,48,168][Random.rand(0..2)]
    bet = Bet.create!(entrants: entrants,
                      completed: false,
                      bet_type: ['Winner Take All', 'Top 3', 'Top Half'][Random.rand(0..2)],
                      cost: cost,
                      start_time: DateTime.now + 1.minute,
                      end_time: DateTime.now + end_time.hours,
                      reward: reward)
    BetKeepOrDestroyJob.perform_at(bet.start_time,bet.id)
end

100.times do |n|
  user = User.find(Random.rand(1..10))
  bet = Bet.find(Random.rand(1..30))
  Lolteam.create(user_id: user.id, bet_id: bet.id, slot1: Summoner.find(1), slot2: Summoner.find(2),
                  slot3: Summoner.find(3), slot4: Summoner.find(4), slot5: Summoner.find(5),
                  slot6: Summoner.find(6), slot7: Summoner.find(7))
  bet.bet_users.create!(bet_id: bet.id, user_id: user.id)
  Bank.create_and_account(bet, user, bet.cost)
end
