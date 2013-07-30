require 'services/github_grabber'

module GithubSupport
  extend ControllerSupport::Base

  include ProjectSupport

  before_filter :set_github_grabber_host

  private

  # this is a hack so we can pass a full url to the Github service
  def set_github_grabber_host
    GithubGrabber.hook_callback_url = project_github_service_hook_url(current_project)
  end

end