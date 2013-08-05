class ReportsController < ApplicationController
	def new
		@report=Report.new
		@catalogs=Catalog.all
	end

	def create
		@report = Report.new(report_params)
		if @report.save

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
			params.require(:report).permit(:catalog_id,:content)
		end
end
