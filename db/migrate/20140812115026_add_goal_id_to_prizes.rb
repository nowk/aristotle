class AddGoalIdToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :goal_id, :integer
  end
end
