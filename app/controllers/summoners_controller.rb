class SummonersController < ApplicationController
  before_action :authenticate_user!
  def index
    @summoners = Summoner.limit(50)
  end

  def show
    @summoner = Summoner.find(params[:id])
  end
end
