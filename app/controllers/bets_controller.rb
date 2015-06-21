class BetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bets = Bet.where(completed: false).where('start_time > ?', DateTime.now).includes(:users).order('start_time ASC')
  end

  def show
    @bet = Bet.find(params[:id])
  end

  def my_noobbets
    @bets = current_user.bets.order(:start_time)
  end

  def my_active_noobbets
    @bets = current_user.bets.where(completed: false)
                             .where('start_time < ?', DateTime.now)
                             .where('end_time > ?', DateTime.now)
    @lolteams = current_user.lolteams.includes(:bet).where(bet_id: @bets.map(&:id))
  end

  def my_upcoming_noobbets
    @bets = current_user.bets.where(completed: false)
                             .where('start_time > ?', DateTime.now)
    @lolteams = current_user.lolteams.includes(:bet).where(bet_id: @bets.map(&:id))
  end

  def my_won_noobbets
    bets = Winning.where(user_id: current_user.id).map { |win| win.bet_id }
    @bets = Bet.find(bets)
    @lolteams = current_user.lolteams.includes(:bet).where(bet_id: @bets.map(&:id))
  end

  def my_finished_noobbets
    @bets = current_user.bets.where(completed: true)
    @lolteams = current_user.lolteams.includes(:bet).where(bet_id: @bets.map(&:id))
  end

  def show_noobbet
    @bet = Bet.find(params[:bet_id])
    @user_objects = @bet.sort_users_by_highest_total_score
    @current_user_team = @user_objects.select { |obj| obj[:user_id] == current_user.id }
                                      .select { |obj| obj[:lolteam_id] == params[:id].to_i  }.first
    lolteams = @bet.lolteams
    @teams = lolteams.map.with_index { |lol| [lol.id,lol.score_user_lolteam] }
  end

end
