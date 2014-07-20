class AddFieldsToGoals < ActiveRecord::Migration
  def change
    add_column :goals, :name, :string
    add_column :goals, :description, :text
    add_column :goals, :user_id, :integer
  end
end
