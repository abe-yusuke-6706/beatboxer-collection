class TagsController < ApplicationController
  skip_before_action :require_login
  skip_before_action :check_mfa
  before_action :set_collect_data

  def index
    @tags = Tag.all.page(params[:page]).per(40)
  end

  def show
    @tag = Tag.find(params[:id])
    @posts = @tag.posts.order(id: :desc).page(params[:page]).per(12)

    render template: "posts/index"
  end

  private

  def set_collect_data
    if current_user
      @bookmarked_post = current_user.bookmark_posts.pluck(:id)
      @liked_post = current_user.like_posts.pluck(:id)
    end
  end
end
