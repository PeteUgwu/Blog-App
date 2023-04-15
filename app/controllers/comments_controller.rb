class CommentsController < ApplicationController
  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to post_path(@comment.post)
    else
      render :new
    end
  end

  private

  def comment_params
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post: current_user.posts.find(params[:post_id]))
  end
end
