class CatalogsController < ApplicationController
	def index
		@catalogs=Catalog.all
	end

	def new
		@catalog= Catalog.new
	end

	def create
		@catalog = Catalog.new(catalog_params)
		if(@catalog.save)
			flash[:success]="Catalog created"
			redirect_to catalogs_path
		else
			render 'new'
		end

	end

	def edit
		@catalog = Catalog.find(params[:id])
	end

	def update
		@catalog = Catalog.find(params[:id])
	    if @catalog.update_attributes(catalog_params)
	      flash[:success] = "Catalog updated"
	      redirect_to catalogs_path
	    else
	      render 'edit'
	    end
	end

	def destroy
		Catalog.find(params[:id]).destroy
		flash[:success] = "Catalog destroyed"
		redirect_to catalogs_path
	end

	private

		def catalog_params
			params.require(:catalog).permit(:title,:detail)
		end
end
