class ApplicationController < ActionController::Base
  protect_from_forgery
  
	
	# rescue_from User::NotAuthorized, :with => :user_not_authorized

	# private
	  # def user_not_authorized
		# flash[:error] = "You don't have access to this section." 
		# redirect_to :back
	  # end
  
end
