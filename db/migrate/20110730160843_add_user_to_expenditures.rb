class AddUserToExpenditures < ActiveRecord::Migration
  def self.up
    add_column :expenditures, :user_id, :integer
  end

  def self.down
    remove_column :expenditures, :user_id
  end
end
