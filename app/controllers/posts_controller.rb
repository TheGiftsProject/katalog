class PostsController < ApplicationController

  include ProjectSupport

  before_filter :sign_in_required
  before_filter :has_project

  def create
    current_project.posts.create(post_params)
    redirect_to current_project
  end

  private

  def post_params
    params[:user] = current_user
    params.require(:post).permit(:text, :user)
  end

end