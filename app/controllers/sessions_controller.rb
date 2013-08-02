class SessionsController < ApplicationController
	def new
	end

  	def create
  		
    	user = User.find_by(email: params[:session][:email].downcase)
    	if user && (Digest::SHA1::hexdigest(params[:session][:password]) == user.password_digest)
      # Sign the user in and redirect to the user's show page.
      		sign_in user
      		#redirect_to user
          render 'report_user'
    	else
      		flash[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
    	end
  	end

  	def destroy
    	sign_out
    	redirect_to root_url
  	end
end

