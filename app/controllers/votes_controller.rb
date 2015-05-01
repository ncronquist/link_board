class VotesController < ApplicationController

  def index

  end

  def create
    # render :json => params
    if params.key?(:post_id)
      thing = Post.find(params[:post_id])
    elsif params.key?(:user_id)
      thing = User.find(params[:user_id])
    else
      return render plain: "invalid input. Stop it!"
    end

    my_vote = thing.votes.find_by_user_id(current_user.id)

    if my_vote.nil?
      current_user.ratings << thing.votes.create(vote_params)
    else
      if (params[:vote][:value].to_i != my_vote.value)
      my_vote.value=params[:vote][:value]
      my_vote.save
      else
        flash[:danger] = "You already voted on that!"
      end
    end

    redirect_to root_path
  end

  def edit

  end

  def update

  end

  private

  def vote_params
    params.require(:vote).permit(:value)
  end
end
