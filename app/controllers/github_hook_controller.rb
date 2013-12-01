require 'github/payload'
require 'github/service_hook'

class GithubHookController < ApplicationController

  include ProjectSupport
  include GithubSupport

  skip_before_filter :verify_authenticity_token, :only => [:post_receive_hook]

  def post_receive_hook
    github_service.process_payload(payload)
    render :nothing => true
  end

  private

  def github_service
    @github_service ||= Github::ServiceHook.new(current_project)
  end

  def payload
    @payload ||= Github::Payload.new(params[:payload])
  end

end
