class TagsController < ApplicationController
  def index
    @tags = Tag.all.page(params[:page]).per(40)
  end
end
