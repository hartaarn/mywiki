class ContentsController < ApplicationController
	def show
		@content = Content.find(params[:id])
		@page = Page.find(@content.page_id)
	end

	def index
	end

	def destroy
    @content = Content.find(params[:id])
    @page = Page.find(@content.page_id)

    authorize! :destroy, @content
    
    @content.destroy
    
    flash[:success] = 'Revision deleted'
    redirect_to pages_url(@page)
  end
end
