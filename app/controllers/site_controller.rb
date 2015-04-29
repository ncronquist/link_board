class SiteController < ApplicationController

  # before_action :is_authenticated?, only: [:secret]

  def index
    @posts = Post.all
  end

  def about
  end

end
