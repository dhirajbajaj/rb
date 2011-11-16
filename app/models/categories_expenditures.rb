class CategoriesExpenditures < ActiveRecord::Base
	attr_accessible :expenditure_id, :category_id
	belongs_to :category
	belongs_to :expenditure
end
