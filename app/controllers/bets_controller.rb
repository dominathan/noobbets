class BetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bets = Bet.where(completed: false).where('start_time > ?', DateTime.now).order('start_time ASC')
  end

  def show
    @bet = Bet.find(params[:id])
  end

  def my_noobbets
    @bets = current_user.bets
  end

  def show_noobbet
    @bet = Bet.find(params[:id])
    lolteams = @bet.lolteams
    @teams = lolteams.map.with_index { |lol| [lol.id,lol.score_user_lolteam] }
  end

end
