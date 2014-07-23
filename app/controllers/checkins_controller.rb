class CheckinsController < ApplicationController
  before_action :set_checkin, only: [:destroy]

  def create
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
