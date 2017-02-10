class AddDayToExpenditure < ActiveRecord::Migration[5.0]
  def change
    add_column :expenditures, :day, :datetime
  end
end
