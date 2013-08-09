class ReportsController < ApplicationController

	def index
		@users = User.all
		@reports = Report.order(:id)
    # binding.pry
  		respond_to do |format|
	    	format.html
	    	format.xls do
	    		headers["Content-disposition"] = 'inline;  filename="Dailyreport.xls"'
	    	end
    	 # { send_data @products.to_csv(col_sep: "\t") }
  		end
	end

	def new
		@report=Report.new
		@catalogs=Catalog.all
	end

	def show
		@user = @user = User.find(params[:id])
	end

	def create
		#check_size_file
		@report = Report.new(report_params)
		if params[:report][:data].present?
			file_name = params[:report][:data].original_filename
			directory = 'public/datas'
			path = File.join(directory,file_name)
			File.open(path, "wb") { |f| f.write(params[:report][:data].read)}
			@report.file_name = file_name
	   		@report.paths = path
	    end
	    @report.user_id = current_user.id
		if @report.save && (File.size(Pathname("public/datas/#{@report.file_name}")) <= 1000000)# || File.size(Pathname("public/datas/#{@report.file_name}")) ==0)  
			redirect_to user_path(current_user)
		else
			flash[:error] = "Maximum of file upload is 1MB"
			@report.destroy
			render 'new'
		end
	end

    def get_name
		respond_to do |format|
			format.json { render json: Catalog.find(params[:id]).detail.to_json }
		end
	end

	def update
		@report = Report.find_by_id(params[:id])
			if params[:report][:data].present?
				file_name = params[:report][:data].original_filename
				path = File.join('public/datas', file_name)
				File.open(@report.paths, "wb") { |f| f.write(params[:report][:data].read)}
				@report.file_name = file_name
	   			@report.paths = path
				if @report.save && params[:report][:data].size > 1000000
					flash[:error] = "Maximum of file upload is 1MB"
					render 'new'
				else
					redirect_to user_path(current_user)
				end
			else
				@report.file_name = @report.paths = ""
				@report.save
				redirect_to user_path(current_user)
			end
	end
	private
		def report_params
			params.require(:report).permit(:catalog_id,:content, :file_name, :paths)
		end

		# def check_size_file
		# 	if params[:report][:data].size < 1000000
		# 		flash[:error] = "jjadsa"
		# 	end
		# end
end
