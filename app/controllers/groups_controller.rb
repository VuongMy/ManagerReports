class GroupsController < ApplicationController
	before_action :sign_in_user, only:[:index,:new,:create,:update,:destroy,:show]
	before_action :admin_user, only:[:index,:new,:create,:update,:destroy,:show]

	def index
		@groups = Group.all
	end

	def show
		@group = Group.find(params[:id])
		@user = @group.user
	end

	def new
		@group=Group.new
	end

	def create
		@group = Group.new(group_params)
		if(@group.save)
			flash[:success]="Group created"
			redirect_to groups_path
		else
			render 'new'
		end
	end

	def edit
		@group = Group.find(params[:id])
	end

	def update
		@group = Group.find(params[:id])
	    if @group.update_attributes(group_params)
	      flash[:success] = "Group updated"
	      redirect_to @group
	    else
	      render 'edit'
	    end
	end

	def destroy
		@group=Group.find(params[:id])
		users = @group.user
		users.each do |user|
			user.group_id=nil
			user.save
		end
		@group.destroy
		flash[:success] = "Group destroyed"
		redirect_to groups_path
	end

	private

		def group_params
			params.require(:group).permit(:group_name,:manager_id)
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
end
