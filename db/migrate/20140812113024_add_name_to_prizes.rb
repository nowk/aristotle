class AddNameToPrizes < ActiveRecord::Migration
  def change
    add_column :prizes, :name, :string
  end
end
