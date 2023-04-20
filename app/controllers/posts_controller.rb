class PostsController < ApplicationController
  load_and_authorize_resource
  before_action :authenticate_user!

  def index
    @user = User.includes(posts: :comments).find(params[:user_id])
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

  def destroy
    @post = Post.find(params[:id])
    authorize! :destroy, @post
    @post.destroy!
    redirect_to user_posts_path(current_user), notice: 'Post was successfully deleted.'
  end

  def post_params
    params
      .require(:post)
      .permit(:title, :text)
      .merge(author: current_user)
  end
end
