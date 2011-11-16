class Friend < ActiveRecord::Base
	belongs_to :user
	
	has_many :expenditure
	
	validates_presence_of :name, :email
	validates :email , :presence => true , :uniqueness => true
	
end
