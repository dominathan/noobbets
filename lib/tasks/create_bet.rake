namespace :create_bet do
  desc 'Create a random bet'
  task :new_bet => :environment do
    puts 'Creating a bet.......'
    cost = [100,200,500,1000,2000,5000,10000][Random.rand(0..6)]
    entrants = Random.rand(1..10)*10
    reward = (cost * entrants) * ( 1 - Bet::NOOBBET_RAKE_PERCENTAGE )
    end_time = [24,48,168][Random.rand(0..2)]
    bet = Bet.create!(entrants: entrants,
                      completed: false,
                      bet_type: ['Winner Take All', 'Top 3', 'Top Half'][Random.rand(0..2)],
                      cost: cost,
                      start_time: DateTime.now + Random.rand(0..12).hours,
                      end_time: DateTime.now + end_time.hours,
                      reward: reward)
    BetKeepOrDestroyJob.perform_at(bet.start_time,bet.id)
    puts 'Bet created!'
  end

  desc "TEST BET RANDOM"
  task :test_bet => :environment do
    puts 'Creating a bet.......'
    cost = [100,200,500,1000,2000,5000,10000][Random.rand(0..6)]
    entrants = Random.rand(1..10)*10
    reward = (cost * entrants) * ( 1 - Bet::NOOBBET_RAKE_PERCENTAGE )
    end_time = [24,48,168][Random.rand(0..2)]
    bet = Bet.create!(entrants: entrants,
                      completed: false,
                      bet_type: ['Winner Take All', 'Top 3', 'Top Half'][Random.rand(0..2)],
                      cost: cost,
                      start_time: DateTime.now + 10.seconds,
                      end_time: DateTime.now + end_time.hours,
                      reward: reward)
    BetKeepOrDestroyJob.perform_at(bet.start_time,bet.id)
    bet.bet_users.create(user_id: User.first, bet_id: bet.id)
    bet.bet_users.create(user_id: User.first, bet_id: bet.id)
    bet.bet_users.create(user_id: User.first, bet_id: bet.id)
    bet.bet_users.create(user_id: User.first, bet_id: bet.id)
    puts 'Bet created!'
  end
end

