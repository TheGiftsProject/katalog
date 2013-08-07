require 'github/grabber'

module GithubSupport
  extend ControllerSupport::Base

  include ProjectSupport

  private

  # this is a hack so we can pass a full url to the Github service
  def set_github_grabber_host
    Github::Grabber.hook_callback_url = project_post_receive_hook_url(current_project)
  end

end