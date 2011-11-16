class CreateCategoriesExpenditures < ActiveRecord::Migration
  def self.up
    create_table :categories_expenditures, :id => false do |t|
	  t.references :category, :expenditure
    end
  end

  def self.down
    drop_table :categories_expenditures
  end
end
