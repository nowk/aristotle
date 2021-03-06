class GoalsController < ApplicationController
  before_action :set_goal, only: [:show, :edit, :update, :destroy]
  before_action :prevent_future_date, only: [:show]
  respond_to :html, :json


  # GET /goals
  # GET /goals.json
  def index
    @goals = Goal.all
  end

  # GET /goals/1
  # GET /goals/1.json
  def show
    @goal_summary = GoalSummary.new(@goal, params[:date_string])
  end

  # GET /goals/new
  def new
    @goal = current_user.goals.new 
  end

  # GET /goals/1/edit
  def edit
  end

  # POST /goals
  # POST /goals.json
  def create
    @goal = current_user.goals.new(goal_params)

    if @goal.save
      flash["notice"] = 'Goal was successfully created.'
    end

    respond_with @goal, location: [current_user, :goals]
  end

  # PATCH/PUT /goals/1
  # PATCH/PUT /goals/1.json
  def update
    if @goal.update(goal_params)
      flash["notice"] = 'Goal was successfully updated.'
    end

    respond_with @goal, location: [current_user, @goal] 
  end

  # DELETE /goals/1
  # DELETE /goals/1.json
  def destroy
    @goal.destroy
    respond_to do |format|
      format.html { redirect_to user_goals_path(current_user.id), notice: 'Goal was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def prevent_future_date
      if DateTime.strptime(params[:date_string], '%m%d%Y') > DateTime.now
        params[:date_string] = DateTime.now.strftime('%m%d%Y')
      end
    rescue ArgumentError
      raise ActionController::RoutingError.new 'Not Found'
    end
  
    # Use callbacks to share common setup or constraints between actions.
    def set_goal
      @goal ||= Goal.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def goal_params
      params[:goal].permit(:name, :description, :minimum_days, cheat_days: [])
    end
end
