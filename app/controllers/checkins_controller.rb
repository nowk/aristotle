class CheckinsController < ApplicationController
  before_action :set_checkin, only: [:destroy]

  def create
    @goal = Goal.find(params[:goal_id])
    @checkin = @goal.checkins.new

    respond_to do |format|
      if @checkin.save
        format.json { render json: { status: 200 } }
      else
        format.json { render json: { status: 500 } }
      end
    end
  end

  def destroy
  end

  private
    def set_checkin
      @checkin = Checkin.find(params[:id])
    end

    def checkin_params
      params[:goal].permit(:goal_id)
    end
end
