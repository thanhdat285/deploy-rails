class AddUserToExpenditure < ActiveRecord::Migration[5.0]
  def change
    add_column :expenditures, :user_id, :integer
  end
end
