class GithubController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def post_receive_hook

    payload = params[:payload]

    return Log.error('Github Post-Receive Hook received empty payload') if payload.blank?


    payload = JSON.parse(payload)


  end

end