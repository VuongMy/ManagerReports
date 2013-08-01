class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end
  def show
    @user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end

  def create
    #UserMailer.registration_confirmation(@user).deliver
    if @user.save
      flash[:success] = "Welcome to the Sample App"
    	redirect_to @user
          UserMailer.registration_confirmation(@user).deliver
          UserMailer.send_to_admin(@user).deliver
    else
      render 'new'
    end
  end

  private
  	def user_params
  		params.require(:user).permit(:email, :password)
  		#khoi tao user voi cac thuoc tinh dien vao
  	end
end
