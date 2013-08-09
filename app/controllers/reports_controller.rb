class ReportsController < ApplicationController
	before_action :sign_in_user, only:[:create]
	def create
		@report = Report.new(report_params)
		if params[:report][:data].present?
		file_name = params[:report][:data].original_filename
		directory = 'public/datas'
		path = File.join(directory,file_name)
		File.open(path, "wb") { |f| f.write(params[:report][:data].read)}
		@report.file_name = file_name
	    @report.paths = path	
		end
		#@report.group_id = current_user.group_id
	    @report.user_id = current_user.id
		if @report.save
			redirect_to user_path(current_user)
			#render 'index'
		else
			render 'new'
		end
	end

    def get_name
		respond_to do |format|
			format.json { render json: Catalog.find(params[:id]).detail.to_json }
		end
	end

	private
		def report_params
			params.require(:report).permit(:catalog_id,:content, :file_name, :paths)
		end

		def sign_in_user
	      redirect_to new_session_path, notice: "Please sign in." unless signed_in?
	    end
end
