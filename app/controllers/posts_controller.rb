class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = User.find(params[:user_id]).posts.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
  
    if @post.save
      redirect_to post_path(@post)
    else
      render :new
    end
  end

  private
  
  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user)
  end
end
