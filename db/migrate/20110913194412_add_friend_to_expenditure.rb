class AddFriendToExpenditure < ActiveRecord::Migration
  def self.up
    add_column :expenditures, :friend_id, :integer
  end

  def self.down
    remove_column :expenditures, :friend_id
  end
end
