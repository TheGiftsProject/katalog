class PostsController < ApplicationController

  include ProjectSupport
  include PostSupport

  before_filter :sign_in_required
  before_filter :project_required

  def create
    post = build_post
    if post.save
      current_project.touch
      respond_to_post(post)
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

  def respond_to_post(post)
    if request.xhr?
      render :partial => 'projects/show/comment', :locals => {:post => post}
    else
      redirect_to current_project
    end
  end

  def post_params
    params.require(:post).permit(:text)
  end

  def build_post
    post = current_project.posts.build(post_params)
    post.user = current_user
    post
  end

end