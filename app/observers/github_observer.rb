require 'services/github_grabber'

class GithubObserver < ActiveRecord::Observer

  observe :project

  def after_create(project)
    project.subscribe_to_service_hook if should_use_service_hook?(project)
  end

  def after_update(project)
    project.subscribe_to_service_hook if should_use_service_hook? and project.repo_url_was.blank?
  end

  def after_destory(project)
    project.unsubscribe_to_service_hook if should_use_service_hook?(project)
  end

  private

  def should_use_service_hook?(project)
    project.repo_url.present?
  end

end