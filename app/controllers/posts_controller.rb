class PostsController < ApplicationController

  include ProjectSupport

  before_filter :sign_in_required
  before_filter :has_project

  def create
    post = build_post
    if post.save
      update_project_status if post.updated?
      current_project.users << current_user unless current_project.users.include? current_user
      redirect_to current_project
    else
      redirect_to current_project, :alert => t('errors.post_fail')
    end
  end

  private

  def post_params
    params.require(:post).permit(:text, :updated)
  end

  def project_params
    params.require(:project).permit(:status)
  end

  def build_post
    post = current_project.posts.build(post_params)
    post.user = current_user
    post
  end

  def update_project_status
    current_project.update(project_params)
  end

end