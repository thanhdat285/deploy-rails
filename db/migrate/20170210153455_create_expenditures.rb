class CreateExpenditures < ActiveRecord::Migration[5.0]
  def change
    create_table :expenditures do |t|
      t.string :name
      t.integer :money

      t.timestamps
    end
  end
end
