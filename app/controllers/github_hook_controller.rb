require 'services/github_payload'
require 'services/github_service_hook'

class GithubHookController < ProjectsController

  include ProjectSupport
  include GithubSupport

  skip_before_filter :verify_authenticity_token, :only => [:post_receive_hook]

  def post_receive_hook
    payload = GithubPayload.new(params[:payload])
    GithubServiceHook.new(current_project, payload).process_payload
  end

end