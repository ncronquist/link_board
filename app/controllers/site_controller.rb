class SiteController < ApplicationController

  # before_action :is_authenticated?, only: [:secret]

  def index
    @posts = Post.all
    @vote = Vote.new
    respond_to do |format|
      format.json{ render json:@posts }
      format.html
    end
  end

  def about
  end

end
