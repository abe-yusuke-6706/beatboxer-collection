class BookmarksController < ApplicationController
  def create
    @post = Post.find(params[:post_id])

    respond_to do |format|
      format.turbo_stream do
        current_user.bookmark(@post)
        flash.now[:notice] = "ブックマークを登録しました！"
        render turbo_stream: [
          turbo_stream.replace("flash-messages", partial: "layouts/flash"),
          turbo_stream.replace("unbookmark-button-#{@post.id}", partial: "posts/bookmarks/bookmark", locals: { post: @post })
        ]
      end
    end
  end

  def destroy
    @post = Post.find(params[:post_id])
    current_user.unbookmark(@post)

    respond_to do |format|
      format.turbo_stream do
        flash.now[:notice] = "ブックマークを解除しました！"
        render turbo_stream: [
          turbo_stream.replace("flash-messages", partial: "layouts/flash"),
          turbo_stream.replace("bookmark-button-#{@post.id}", partial: "posts/bookmarks/unbookmark", locals: { post: @post })
        ]
      end
    end
  end
end
