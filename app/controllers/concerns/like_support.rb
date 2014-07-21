module LikeSupport

  extend ControllerSupport::Base
  include UserSupport
  include ProjectSupport

  helper_method :likes_current_project?, :likes_project?

  def likes_project?(project)
    project.likes.find_by(:user => current_user).present?
  end

  def likes_current_project?
    current_project_like.present?
  end

  def unlike_current_project
    current_project_like.destroy
  end

  def like_current_project
    Like.create!(:user => current_user, :project => current_project)
    session[:liked_project_id] = current_project.id if params[:widget]
  end

  def has_previous_liked_project
    previously_liked_project.present?
  end

  def previously_liked_project
    @_previously_liked_project ||= Project.find_by(id: session[:liked_project_id])
  end

  def reset_previously_liked_project
    session[:liked_project_id] = nil
  end

  private

  def current_project_like
    @_like ||= current_user.likes.find_by(:project => current_project)
  end

end