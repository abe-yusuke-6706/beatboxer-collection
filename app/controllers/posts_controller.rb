class PostsController < ApplicationController
    skip_before_action :require_login, only: [ :index ]
    skip_before_action :check_mfa, only: [ :index ]
    before_action :set_collect_data, only: [ :bookmarks, :likes, :index, :show ]

    def bookmarks
        if @bookmarked_post.blank?
            flash[:alert] = "ブックマークが登録されていません！"
            redirect_to root_path
            return
        end

        @bookmark_list = Post.where(id: current_user.bookmarks.pluck(:post_id)).page(params[:page]).per(12)
    end

    def likes
        if @liked_post.blank?
            flash[:alert] = "いいねが登録されていません！"
            redirect_to root_path
            return
        end

        @like_list = Post.where(id: current_user.likes.pluck(:post_id)).page(params[:page]).per(12)
    end

    def index
        @posts = Post.order(id: :desc).page(params[:page]).per(12)
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
        @comments = @post.comments.includes(:user).order(created_at: :desc)
    end

    def new
        @post = Post.new
    end

    def create
        post = Post.new(post_params)
        if post.save
            flash[:notice] = "投稿しました！"
            redirect_to root_path
        else
            flash.now[:alert] = "投稿できませんでした！"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
    end

    def destroy
    end

    private

    def post_params
      params.require(:post).permit(:title, :youtube_video, :body).merge(user_id: current_user.id)
    end

    def set_collect_data
        if current_user
            @bookmarked_post = current_user.bookmark_posts.pluck(:id)
            @liked_post = current_user.like_posts.pluck(:id)
        end
    end
end
