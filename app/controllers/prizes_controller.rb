class PrizesController < ApplicationController
  before_action :set_prize, only: [:show, :edit, :update, :destroy]
  respond_to :html, :json

  # GET /prizes
  # GET /prizes.json
  def index
    @prizes = Prize.all
  end

  # GET /prizes/1
  # GET /prizes/1.json
  def show
  end

  # GET /prizes/new
  def new
    @prize = Prize.new
    @goal = Goal.find(params[:goal_id])
  end

  # GET /prizes/1/edit
  def edit
  end

  # POST /prizes
  # POST /prizes.json
  def create
    @goal = Goal.find(params[:goal_id])
    @prize = @goal.prizes.new(prize_params)

    if @prize.save
      flash[:notice] = 'Prize was successfully created.'
      redirect_to [current_user, @goal, @prize]
    end

  end

  # PATCH/PUT /prizes/1
  # PATCH/PUT /prizes/1.json
  def update
    if @prize.update(prize_params)
      flash[:notice] = 'Prize was successfully updated.'
    end

    respond_with @prize
  end

  # DELETE /prizes/1
  # DELETE /prizes/1.json
  def destroy
    @prize.destroy
    respond_to do |format|
      format.html { redirect_to prizes_url, notice: 'Prize was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_prize
      @prize = Prize.find(params[:id])
      @goal = Goal.find(params[:goal_id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def prize_params
      params[:prize].permit(:name)
    end
end
