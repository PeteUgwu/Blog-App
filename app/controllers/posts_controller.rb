class PostsController < ApplicationController
  def index
    @user = User.includes(:posts).find(params[:user_id])
  end

  def show
    @post = User.find(params)[:user_id].posts.find(params[:id])
  end
end
