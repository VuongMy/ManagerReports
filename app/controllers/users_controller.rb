class UsersController < ApplicationController
  before_action :sign_in_user, only: [:show,:update,:edit,:index,:destroy]
  before_action :admin_user, only: [:index, :destroy]

  def index
  	@users = User.paginate(:page => params[:page], :per_page => 20 )
    @report = Report.all
  end

  def show
    @user = User.find(params[:id])
  end
  
  def new
  	@user = User.new
  end

  def create
    @user = User.new(user_params)
    @user.password = @user.password_confirmation = SecureRandom.hex(8)

    if @user.save
      UserMailer.registration_confirmation(@user).deliver
      UserMailer.activation(@user).deliver

      flash[:success] = "Welcome to the Sample App"
    	#sign_in @user
      #redirect_to user_path(@user)
      render 'wating'
    else
      render 'new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by_id(params[:id])
    # add group
    if params[:confirmed]=="true"
      if params[:group_id] != nil
        @user.group_id = params[:group_id]
        flash[:success] = "User changed group."
      end
      @user.active="true"
      @user.save
      redirect_to users_path
    end
    #remove group_id
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
    #change password
    if params[:user]!=nil
      if params[:user][:password]!="" && params[:user][:password_confirmation]!=""
        if params[:user][:password].length >= 6
          if params[:user][:password]==params[:user][:password_confirmation]
            @user.password = @user.password_confirmation=params[:user][:password]
            flash[:success]="Passwod updated"
            @user.save
            redirect_to @user
          else
            flash[:error]="Passwod confirmation not match"
            render 'edit'  
          end
        else
          flash[:error]="Password too short"
          render 'edit'  
        end
      else
        flash[:error]="Password/Passwod confirmation invalid"
        render 'edit'
      end
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
  	end

    def admin_user
      unless current_user.admin?
        store_location
        redirect_to current_user,notice: "Permission Denied"
      end
    end

    def sign_in_user
      redirect_to new_session_path, notice: "Please sign in." unless signed_in?
    end

    def signed_in_user
      redirect_to signin_url, notice: "Please sign in." unless signed_in?
    end
end
