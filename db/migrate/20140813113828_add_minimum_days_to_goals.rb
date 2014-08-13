class AddMinimumDaysToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :minimum_days, :integer
  end
end
