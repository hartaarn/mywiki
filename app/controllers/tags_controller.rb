class TagsController < ApplicationController

  def create
    @tag = Tag.find_or_create(params[:tag][:tag])
    @page = Page.where(id: params[:page_id]).first
  end
end
