class UsersController < ApplicationController

  before_action :admin_user, only: [:index, :edit, :update, :destroy]

  def index
  	@users = User.paginate(:page => params[:page], :per_page => 20 )
     # @group = Group.find(:id);
  end

  def show
    @user = User.find(params[:id])
   
  end
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(params[:id])
    @user.password = @user.password_confirmation = SecureRandom.hex(8)

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      UserMailer.activation(@user).deliver

      flash[:success] = "Welcome to the Sample App"
    	sign_in @user
      redirect_to 'reports/new'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(user_params)
  end

  def update
    # binding.pry
    @user = User.find_by_id(params[:id])
    # @user.group_id = params[group_id] if params[:group_id]
    if params[:confirmed]=="true"
      if params[:group_id] == nil
        flash[:eroors] = "Group nil"
      else
        @user.group_id = params[:group_id]
      end
      @user.active="true"
      @user.save
      redirect_to users_path
    end
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
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
  		params.require(:user).permit(:email, :password, :password_confirmation, :group_id, :active )
      # params.require(:group).permit( :group_name)
  		#khoi tao user voi cac thuoc tinh dien vao
  	end

    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
end
