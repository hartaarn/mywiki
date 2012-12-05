class PagesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :show]
  def index
    #@pages = current_user.pages
    
    #@pages = Page.all
    
    #@pages = Page.order("created_at").page(params[:page]).per(5)

    kw          = params[:search]
    @pages = Page.where("title LIKE ?","%#{kw}%").order("created_at DESC").page(params[:page]).per(5)

    #@pages = Page.search_by_title(params[:search]).page(params[:page]).per(5)
  end

  def create
    @page = Page.new
    authorize! :create, @page
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

  def update
    @page = Page.find(params[:id])
    authorize! :update, @page
    @page.title = params[:page][:title]
    @page.created_by = current_user.id

    @page.set_content params[:page][:current_body]


    if @page.save
      flash[:success] = 'Page updated'
      redirect_to @page
    else
      flash[:error] = 'Please correct the errors below'
      render :new
    end
  end

  def new
    @page = Page.new
    authorize! :create, @page
  end

  def show
    #@page = current_user.pages.where(id: params[:id]).first
    #@page = Page.where(id: params[:id]).first
    @page = Page.find(params[:id])
    @tag = Tag.new
  end

  def edit
    @page = Page.where(id: params[:id]).first
    authorize! :edit, @page
  end

  def destroy
    @page = current_user.pages.where(id: params[:id]).first
    authorize! :destroy, @page
    @page.destroy
    flash[:success] = 'Page deleted'
    redirect_to pages_url
  end

end
