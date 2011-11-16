class User < ActiveRecord::Base
  # Include default devise modules. Others available are:  
  # :token_authenticatable, :lockable, :timeoutable and :activatable  
  # :confirmable  
  devise :database_authenticatable, :registerable,   
		 :recoverable, :rememberable, :trackable, :validatable  
  
  # Setup accessible (or protected) attributes for your model  
  attr_accessible :email, :name, :thumb, :password, :password_confirmation  

  has_many :authentications
  has_many :expenditure
  has_many :friend
  # has_many :expenditure,:through => :friend


	def apply_omniauth(omniauth)
	  # self.email = omniauth['user_info']['email'] if email.blank?
	  # self.thumb = omniauth['user_info']['email'] if email.blank?
	  # self.name = omniauth['user_info']['name'] if name.blank?
	  save_profile(omniauth)
	  authentications.build(:provider => omniauth['provider'], :uid => omniauth['uid'],:token => omniauth['credentials']['token'])
	end

	def save_profile(omniauth)
	  self.email = omniauth['user_info']['email'] if email.blank?
	  self.thumb = omniauth['user_info']['image'] if ( thumb.blank? && omniauth['provider'] == 'twitter' )
	  self.fbthumb = omniauth['user_info']['image'] if ( fbthumb.blank? && omniauth['provider'] == 'facebook' )
	  self.name = omniauth['user_info']['name'] if name.blank?
	  self.save
	end

	def current_thumb(currauth)
	   if ( self.thumb? && currauth == 'twitter')
			return self.thumb  
		elsif self.fbthumb?   
			return self.fbthumb  
		else 
			return self.thumb  
	 end 
	end

	def password_required?
	  super
	end

end
