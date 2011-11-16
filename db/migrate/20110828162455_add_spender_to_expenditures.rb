class AddSpenderToExpenditures < ActiveRecord::Migration
  def self.up
    add_column :expenditures, :spender_id, :integer
  end

  def self.down
    remove_column :expenditures, :spender_id
  end
end
