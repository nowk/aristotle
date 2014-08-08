class AddCheatDaysToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :cheat_days, :string
  end
end
