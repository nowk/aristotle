class CheckinsController < ApplicationController
  def create
    @goal = Goal.find(params[:goal_id])
    @checkin = @goal.checkins.new(truncated_date: params[:truncated_date])

    respond_to do |format|
      if @checkin.save
        format.html { redirect_to user_goal_path(current_user.id, @goal.id), notice: 'You just checked in! Great work!' }
        format.json { render json: { status: 200 } }
      else
        format.json { render json: { status: 500 } }
      end
    end
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @goal = @checkin.goal
    respond_to do |format|
      if @checkin.destroy
        format.html { redirect_to user_goal_path(current_user.id, @goal), notice: 'Checked out for today.' }
        format.json { render json: { status: 200, total_checkins: @goal.checkins.count } }
      else
        format.json { render json: { status: 500, total_checkins: @goal.checkins.count } }
      end
    end
  end

  private
    def checkin_params
      params[:goal].permit(:goal_id)
    end
end
