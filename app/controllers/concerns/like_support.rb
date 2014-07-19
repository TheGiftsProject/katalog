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
    Like.create(:user => current_user, :project => current_project)
  end

  private

  def current_project_like
    @_like ||= current_user.likes.find_by(:project => current_project)
  end

end