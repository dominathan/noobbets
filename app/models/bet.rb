class Bet < ActiveRecord::Base
  has_many :users, through: :bet_users
  has_many :bet_users, dependent: :destroy
  has_many :lolteams, dependent: :destroy
  has_many :banks, dependent: :destroy

  validates_presence_of :start_time, :end_time, :cost, :bet_type, :entrants, :reward
  before_save :completed_starts_false, :end_time_after_start

  NOOBBET_RAKE_PERCENTAGE = 0.1

  def sort_users_by_highest_total_score
    self.lolteams.map  { |lol| lol.score_user_lolteam }.sort_by { |k,v| k['total_score'] }.reverse
  end

  def self.keep_or_destroy(bet_id)
    bet = Bet.find(bet_id)
    if bet.users.count < 3
      # Give money back to the original entries
      # and destroy the bet...
      bet.users.each { |usr| usr.update_attribute(:fake_money, (usr.fake_money + bet.cost) ) }
      bet.destroy
      return false
    else
      return true
    end
  end

  private
    def completed_starts_false
      self.completed == false
    end

    def end_time_after_start
      self.start_time < self.end_time
    end


end
