  class LolteamsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lolteam, only: [:show, :edit, :update, :destroy]
  before_action :set_bet

  def index
    @lolteams = Lolteam.where(user_id: current_user.id)
  end

  def show
  end

  def new
    @lolteam = Lolteam.new
    @summoners = Summoner.order('total_score DESC').map { |summoner| [summoner.name, summoner.id] }
  end

  def edit
  end

  def create
    @summoners = Summoner.order('total_score DESC').map { |summoner| [summoner.name, summoner.id] }
    @lolteam = Lolteam.new(lolteam_params)
    @lolteam.bet_id = @bet.id
    @lolteam.user_id = current_user.id

    respond_to do |format|
      if @lolteam.save && current_user.fake_money >= @bet.cost
        # Add the User to counter for the bets if you join.
        @bet.bet_users.create!(bet_id: @bet.id, user_id: current_user.id)
        Bank.create_and_account(@bet, current_user, @bet.cost)
        format.html { redirect_to bets_path, notice: 'Lolteam was successfully created.' }
      else
        format.html { render :new }
        format.json { render json: @lolteam.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @lolteam.update(lolteam_params)
        format.html { redirect_to bets_path, notice: 'Lolteam was successfully updated.' }
        format.json { render :show, status: :ok, location: @lolteam }
      else
        format.html { render :edit }
        format.json { render json: @lolteam.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @lolteam.destroy
    respond_to do |format|
      format.html { redirect_to lolteams_url, notice: 'Lolteam was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def score
    @lolteam = Lolteam.find(params[:id])
    @score = @lolteam.score_user_lolteam
    respond_to do |format|
      format.json { render json: @score }
    end
  end

  private
    def set_lolteam
      @lolteam = Lolteam.find(params[:id])
    end

    def set_bet
      @bet = Bet.find(params[:bet_id])
    end

    def lolteam_params
      params.require(:lolteam).permit(:slot1, :slot2, :slot3, :slot4, :slot5, :slot6, :slot7)
    end
end
