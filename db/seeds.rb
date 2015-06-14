# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
WebMock.allow_net_connect!
GetRiotAPI.get_summoner_ids(GetTopSummoners.get_from_lolking(1))
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
  bet = Bet.create!(entrants: Random.rand(1..10)*10,
              completed: false,
              bet_type: ['Winner Take All', 'Top 3', 'Top Half'][Random.rand(0..2)],
              cost: [100,200,500,1000,2000,5000,10000][Random.rand(0..6)],
              start_time: DateTime.now + Random.rand(0..48).hours,
              end_time: DateTime.now + Random.rand(48..216).hours)
  PayoutCalculatorJob.perform_at(bet.end_time + 4.hours, bet.id)
end
