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

	private
		def report_params
			params.require(:report).permit(:catalog_id,:content)
		end
end
