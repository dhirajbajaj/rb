class AddFbthumbToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :fbthumb, :string
  end

  def self.down
    remove_column :users, :fbthumb
  end
end
