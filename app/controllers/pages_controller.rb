class PagesController < ApplicationController
  def index
  end

  def create
    @page = Page.new
    @page.title = params[:page][:title]
    @page.created_by = current_user.id

    if @page.save
      flash[:success] = 'Page created'
      redirect_to pages_url
    else
      flash[:error] = 'Please correct the errors below'
      render :new
    end
  end

  def new
    @page = Page.new

  end


end
