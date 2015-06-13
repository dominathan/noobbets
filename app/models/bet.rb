class Bet < ActiveRecord::Base
  has_many :users, through: :bet_users
  has_many :bet_users
  has_many :lolteams
  has_many :banks

  validates_presence_of :start_time, :end_time, :cost, :bet_type, :entrants
  before_save :completed_starts_false, :end_time_after_start

  def sort_users_by_highest_total_score
    self.lolteams.map  { |lol| lol.score_user_lolteam }.sort_by { |k,v| k['total_score'] }.reverse
  end

  private
    def completed_starts_false
      self.completed == false
    end

    def end_time_after_start
      self.start_time < self.end_time
    end


end
