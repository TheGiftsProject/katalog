class GithubController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def post_receive_hook

    payload = params[:payload]

    return Log.error('Github Post-Receive Hook received empty payload') if payload.blank?


    payload = JSON.parse(payload)

    # check if payload.ref == "refs/heads/master" ??

    # find project by payload.repository.url
    # project.update_last_commit  payload.head_commit.timestamp

  end

end