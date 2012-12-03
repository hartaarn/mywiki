class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  def index
    #@pages = current_user.pages
    @pages = Page.all
  end

  def create
    @page = Page.new
    @page.title = params[:page][:title]
    @page.created_by = current_user.id

    if @page.save
      @page.contents.create! body: params[:page][:body]
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

  def show
    #@page = current_user.pages.where(id: params[:id]).first
    @page = Page.where(id: params[:id]).first
    @tag = Tag.new
  end

  def destroy
    @page = current_user.pages.where(id: params[:id]).first
    @page.destroy
    flash[:success] = 'Page deleted'
    redirect_to pages_url
  end

end
