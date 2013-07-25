require 'services/github_grabber'

class GithubObserver

  observe :project

  def after_create(project)
    grabber_for(project).subscribe_to_service_hook
  end

  def after_destory(project)
    grabber_for(project).unsubscribe_to_service_hook
  end

  private

  def grabber_for(project)
    GithubGrabber.from_project(project)
  end

end