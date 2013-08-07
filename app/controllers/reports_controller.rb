class ReportsController < ApplicationController
	def new
		@report=Report.new
		@catalogs=Catalog.all
	end

	def create
		@report = Report.new(report_params)
		if params[:datafile].present?
			file_name =  File.basename(params[:datafile]) #File.extname(params[:datafile]))
			#file_name = sanitize_file_name(params[:datafile].original_filename)
			directory = 'public/datas'
			path = File.join(directory,file_name)
	    	File.open(path, "wb") { |f| f.write(params[:datafile].read)}
	    	@report.file_name = file_name
	    	@report.paths = path	
		end
		#@report.group_id = current_user.group_id
	    @report.user_id = current_user.id
		if @report.save
			redirect_to user_path(current_user)
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
end
