class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])
    current_user.like(@post)
    @post.reload

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("flash-messages", partial: "layouts/flash"),
          turbo_stream.replace("unlike-button-#{@post.id}", partial: "posts/likes/like", locals: { post: @post }),
          turbo_stream.replace("like-count-#{@post.id}", partial: "posts/likes/like_count", locals: { post: @post })
        ]
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.unlike(@post)
    @post.reload

    respond_to do |format|
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("flash-messages", partial: "layouts/flash"),
          turbo_stream.replace("like-button-#{@post.id}", partial: "posts/likes/unlike", locals: { post: @post }),
          turbo_stream.replace("like-count-#{@post.id}", partial: "posts/likes/like_count", locals: { post: @post })
        ]
      end
    end
  end
end
