class CreateFinancial < ActiveRecord::Migration[5.0]
  def change
    create_table :financials do |t|
      t.string :name
      t.string :money
      t.datetime :day
      t.references :user, foreign_key: true
    end
  end
end
