class AddSpenderNameToExpenditures < ActiveRecord::Migration
  def self.up
    add_column :expenditures, :spender_name, :string
  end

  def self.down
    remove_column :expenditures, :spender_name
  end
end
