class CommentsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!, only: [:create]

  def new
    @comment = Comment.new
  end

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.author = current_user

    if @comment.save
      redirect_to user_post_path(params[:user_id], params[:post_id])
    else
      render :new
    end
  end

  def destroy
    @comment = Comment.find(params[:id])
    authorize! :destroy, @comment
    @comment.destroy
    redirect_to user_post_path(params[:user_id], params[:post_id]), notice: 'Comment was successfully deleted.'
  end

  def comment_params
    @post = Post.find_by(id: params[:post_id])
    params
      .require(:comment)
      .permit(:text)
      .merge(author: current_user, post: @post)
  end
end
