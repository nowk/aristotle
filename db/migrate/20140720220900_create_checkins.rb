class CreateCheckins < ActiveRecord::Migration
  def change
    create_table :checkins do |t|
      t.integer :goal_id

      t.timestamps
    end
  end
end
