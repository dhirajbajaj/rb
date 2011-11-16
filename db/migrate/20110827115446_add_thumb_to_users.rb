class AddThumbToUsers < ActiveRecord::Migration
  def self.up
    add_column :users, :thumb, :string
  end

  def self.down
    remove_column :users, :thumb
  end
end
