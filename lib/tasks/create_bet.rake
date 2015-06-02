namespace :create_bet do
  desc 'Create a random bet'
  task :new_bet => :environment do
    puts 'Creating a bet.......'
    Bet.create!(entrants: Random.rand(1..10)*10,
                completed: false,
                bet_type: ['Winner Take All', 'Top 3', 'Top Half'][Random.rand(0..2)],
                cost: [100,200,500,1000,2000,5000,10000][Random.rand(0..6)],
                start_time: DateTime.now + Random.rand(0..48).hours,
                end_time: DateTime.now + Random.rand(48..216).hours)
    puts 'Bet created!'
  end
end
