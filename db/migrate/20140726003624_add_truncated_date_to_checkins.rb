class AddTruncatedDateToCheckins < ActiveRecord::Migration
  def change
    add_column :checkins, :truncated_date, :string
  end
end
