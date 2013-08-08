class SessionsController < ApplicationController
	def new
	end

  	def create
  		
    	user = User.find_by(email: params[:session][:email].downcase)
    	if user && user.authenticate(params[:session][:password]) && user.active
      		sign_in user
          if user.admin?
      		  redirect_to users_path
          else
            redirect_to user_path(current_user)
          end
    	else
      		flash.now[:error] = 'Invalid email/password combination' # Not quite right!
      		render 'new'
    	end
  	end

  	def destroy
    	sign_out
    	redirect_to root_url
  	end
end

