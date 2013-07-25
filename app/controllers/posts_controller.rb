class PostsController < ApplicationController

  include ProjectSupport

  before_filter :sign_in_required
  before_filter :has_project

  def create
    post = build_post
    if post.save
      redirect_to current_project, :notice => t('notices.post_created')
    else
      redirect_to current_project, :alert => t('errors.post_fail')
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :updated)
  end

  def build_post
    post = current_project.posts.build(post_params)
    post.user = current_user
    post
  end

end