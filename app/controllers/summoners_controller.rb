class SummonersController < ApplicationController
  before_action :authenticate_user!

  def index
    @summoners = Summoner.order('total_score DESC')
  end

  def show
    @summoner = Summoner.find(params[:id])
  end

  def score
    summoner = Summoner.find(params[:id])
    @score = {}
    @score['total_score'] = summoner.score_summoner_games_over_user_timeframe('total_score',DateTime.now - 7.days,DateTime.now).to_json
    @score['champions_killed'] = summoner.score_summoner_games_over_user_timeframe('champions_killed',DateTime.now - 7.days,DateTime.now).to_json
    @score['num_deaths'] = summoner.score_summoner_games_over_user_timeframe('num_deaths',DateTime.now - 7.days,DateTime.now).to_json
    @score['assists'] = summoner.score_summoner_games_over_user_timeframe('assists',DateTime.now - 7.days,DateTime.now).to_json
    respond_to do |format|
      format.json { render json: @score }
    end
  end
end
