class CommentsController < ApplicationController

  def index
    # render :json => params
    @post = Post.find(params[:post_id])
    @comments = @post.comments
    @vote = Vote.new
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = Comment.new
  end

  def create
    # render :json => params
    @post = Post.find(params[:post_id])
    current_user.comments << @post.comments.create(comment_params)
    redirect_to post_comments_path(post_id: params[:post_id])
  end



  private

  def comment_params
    params.require(:comment).permit(:body)
  end

end
