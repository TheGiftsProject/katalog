require 'services/github_grabber'

class GithubObserver < ActiveRecord::Observer

  observe :project

  def after_create(project)
    project.subscribe_to_service_hook
  end

  def after_destory(project)
    project.unsubscribe_to_service_hook
  end

end