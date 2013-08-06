class UsersController < ApplicationController
  
  def index
  	@users = User.all
  end
  def show
    @user = User.find(params[:id])
    @groups = Group.all;
  end
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    
    #UserMailer.registration_confirmation(@user).deliver
    if @user.save
      #sign_in @user
      UserMailer.registration_confirmation(@user).deliver
      #UserMailer.send_to_admin(@user).deliver
      UserMailer.activation(@user).deliver
      flash[:success] = "Welcome to the Sample App"
    	#redirect_to @user
      render 'show'
    else
      render 'new'
    end
  end

  def update
    @user = User.find_by_id(params[:id])
    if params[:removed]== "true"
      temp=@user.group_id
      @group = Group.find_by_id(temp)
      if @user.id==@group.manager_id
        @group.manager_id=nil
        @group.save
      end
      @user.group_id=nil
      @user.save
      redirect_to group_path(temp)
    end

  end

  def send_activation
      generate_token(:activation_token)
      UserMailer.activation(self).deliver
    end

    def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])
  end
  private
  	def user_params
  		params.require(:user).permit(:email, :password)
  		#khoi tao user voi cac thuoc tinh dien vao
  	end
end
