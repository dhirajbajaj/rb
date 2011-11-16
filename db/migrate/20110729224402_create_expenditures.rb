class CreateExpenditures < ActiveRecord::Migration
  def self.up
    create_table :expenditures do |t|
      t.integer :amount
      t.string :desc
      t.datetime :date
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :expenditures
  end
end
