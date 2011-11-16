class Expenditure < ActiveRecord::Base
	validates :amount, :numericality => true, :presence => {:message => "can't be blank"}
	validates_presence_of :date
	validates_presence_of :desc
	
	belongs_to :user
	belongs_to :friend
	has_and_belongs_to_many :category
	
	attr_reader :cat_tokens , :dir
	def cat_tokens=(ids)
		self.category_ids = ids.split(",")
	end
	def dir=( val )
		if(val)
		end
	end
	
	def setDefaultVal(name,dir)
		self.spender_name = name!="" ? name:"me"
		if(dir==0)
			if(self.amount>0)#make it negative if +ve
				self.amount = (-1)*(self.amount)
			end
		end
		if(dir==1)
			if(self.amount<0)#make it +ve if -ve
				self.amount = (-1)*(self.amount)
			end
		end
		# self.spender_id = id ? id : current_user.id
		# self.desc = desc!="" ? desc : "-NA-"
	end

end
