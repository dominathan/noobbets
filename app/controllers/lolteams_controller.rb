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
  end

  def edit
  end

  def create
    @lolteam = Lolteam.new(lolteam_params)
    @lolteam.bet_id = @bet.id
    @lolteam.user_id = current_user.id

    respond_to do |format|
      if @lolteam.save
        # Add the User to counter for the bets if you join.
        @bet.bet_users.create!(bet_id: @bet.id, user_id: current_user.id)
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
