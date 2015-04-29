class PostsController < ApplicationController

  before_action :is_authenticated?

  def index
    @posts = current_user.posts
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    redirect_to posts_path
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to post
  end

  def destroy
    post = Post.find(params[:id])
    post.delete!(post_params)
    redirect_to posts
  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :post)
  end

end
