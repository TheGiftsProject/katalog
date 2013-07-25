require 'services/github_grabber'

module GithubSupport
  extend ControllerSupport::Base

  def set_github_grabber_host
    GithubGrabber.hook_callback_url = github_post_receive_hook_url()
  end

end