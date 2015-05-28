class BetsController < ApplicationController
  before_action :authenticate_user!

  def index
    @bets = Bet.where(completed: false).order('start_time ASC')
  end

end
