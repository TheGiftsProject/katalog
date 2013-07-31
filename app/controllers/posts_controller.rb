class PostsController < ApplicationController

  include ProjectSupport
  include PostSupport

  before_filter :sign_in_required
  before_filter :has_project

  def create
    post = build_post
    if post.save
      add_user_to_project
      project_changed = update_project_status

      respond_to_post(post, project_changed)
    else
      if request.xhr?
        flash[:alert] = t('errors.post_fail')
        render :json => {:refresh => true, :url => project_path(current_project)}
      else
        redirect_to current_project, :alert => t('errors.post_fail')
      end
    end
  end

  def destroy
    if current_post.user == current_user
      current_post.destroy
    else
      flash[:error] = t('errors.cant_delete')
    end
    redirect_to current_project
  end

  private

  def respond_to_post(post, project_changed)
    if request.xhr?
      if project_changed
        render :json => {:refresh => true, :url => project_path(current_project)}
      else
        render :partial => 'projects/show/comment', :locals => {:post => post}
      end
    else
      redirect_to current_project
    end
  end

  def add_user_to_project
    current_project.users << current_user unless current_project.users.include? current_user
  end

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
    current_project.assign_attributes(project_params)
    changed = current_project.changed?
    current_project.save
    changed
  end

end