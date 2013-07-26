require 'services/github_service_hook'

class GithubController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def post_receive_hook
    GithubServiceHook.new(params[:payload]).process_payload
  end

end