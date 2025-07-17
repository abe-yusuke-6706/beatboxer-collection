class LikesController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.turbo_stream do
        current_user.like(@post)
        render turbo_stream: [
          turbo_stream.replace("flash-messages", partial: "layouts/flash"),
          turbo_stream.replace("unlike-button-#{@post.id}", partial: "posts/likes/like", locals: { post: @post })
        ]
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    like = current_user.likes.find_by(post: @post)
    like.destroy

    respond_to do |format|
      format.turbo_stream do
        current_user.unlike(@post)
        render turbo_stream: [
          turbo_stream.replace("flash-messages", partial: "layouts/flash"),
          turbo_stream.replace("like-button-#{@post.id}", partial: "posts/likes/unlike", locals: { post: @post })
        ]
      end
    end
  end
end
