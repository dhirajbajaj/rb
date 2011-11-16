class AuthenticationsController < ApplicationController
  def index
	@authentications = current_user.authentications if current_user
  end

  def create
	# render :text => request.env["omniauth.auth"].to_json
	omniauth = request.env["omniauth.auth"]
	authentication = Authentication.find_by_provider_and_uid(omniauth['provider'], omniauth['uid'])
	current_user = User.find_by_name(omniauth['user_info']['name']) if ( omniauth['provider'] == 'twitter' )
	current_user = User.find_by_email(omniauth['user_info']['email']) if ( omniauth['provider'] == 'facebook')
	session[:currauth] = omniauth['provider']
	 if authentication
		flash[:notice] = "Signed in successfully."
		sign_in(:user, authentication.user)
		current_user.save_profile(omniauth)
		redirect_to expenditures_url
	 elsif current_user
		current_user.save_profile(omniauth)
		current_user.authentications.create!(:provider => omniauth['provider'], :uid => omniauth['uid'], :token => omniauth['credentials']['token'])
		flash[:notice] = "Authentication successful."
		redirect_to expenditures_url
	 else
		user = User.new
		user.apply_omniauth(omniauth)
		if user.save
		  flash[:notice] = "Welcome user!!!You are Registered successfully."
		  sign_in_and_redirect(:user, user)
		else
		  session[:omniauth] = omniauth.except('extra')
		  redirect_to new_user_registration_url
		end
	 end
  end

  def destroy
    @authentication = Authentication.find(params[:id])
    @authentication.destroy
    redirect_to authentications_url, :notice => "Successfully destroyed authentication."
  end
end
