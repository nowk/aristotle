class CheckinsController < ApplicationController
  self.responder = CheckinResponder
  respond_to :html, :json

  def create
    @checkin = Checkin.new goal_id: params[:goal_id], truncated_date: params[:truncated_date]
    if @checkin.save
      flash[:notice] = 'You just checked in! Great work!'
    end

    respond_with @checkin, 
      location: goal_with_date_path(current_user.id, @checkin.goal_id, @checkin.truncated_date)
  end

  def destroy
    @checkin = Checkin.find(params[:id])
    @goal = @checkin.goal
    if @checkin.destroy
      flash[:notice] = 'Checked out for today.'
    end

    respond_with @checkin, 
      location: goal_with_date_path(current_user.id, @goal, @checkin.truncated_date), 
      total_checkins: @goal.checkins.count
  end

  private
    def checkin_params
      params[:goal].permit(:goal_id)
    end
end
