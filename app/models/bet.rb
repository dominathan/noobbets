class Bet < ActiveRecord::Base
  has_many :users, through: :bet_users
  has_many :bet_users

  has_many :lolteams

  validates_presence_of :start_time, :end_time, :cost, :bet_type, :entrants
  before_save :completed_starts_false, :end_time_after_start

  # def self.create_bet(start_time, end_time, cost, bet_type, entrants)
  #   Bet.create(entrants: entrants, completed: false, bet_type: bet_type,
  #              cost: cost, start_time: start_time, end_time: end_time)
  # end


  private
    def completed_starts_false
      self.completed == false
    end

    def end_time_after_start
      self.start_time < self.end_time
    end


end
