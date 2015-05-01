class PostsController < ApplicationController

  before_action :is_authenticated?

  def index
    @posts = current_user.posts
  end

  def show
    @posts = Post.find(params[:id])
  end

  def new
    @post = Post.new
  end

  def create
    @post = current_user.posts.create(post_params)
    # redirect_to posts_path

    if @post['id'].nil?
      flash[:danger] = "Error trying to create new post"
      render :new
    else
      flash[:success] = "Post Creation Successful!"
      redirect_to posts_path
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def update
    post = Post.find(params[:id])
    post.update!(post_params)
    redirect_to posts_path
  end

  def destroy
    Post.find(params[:id]).destroy
    redirect_to posts_path
  end

  private

  def post_params
    params.require(:post).permit(:title, :link, :post)
  end

end
