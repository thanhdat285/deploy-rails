class CreateTimeManagers < ActiveRecord::Migration[5.0]
  def change
    create_table :time_managers do |t|
      t.datetime :from
      t.datetime :to
      t.string :name
      t.integer :status, default: 0
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
