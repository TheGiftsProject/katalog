class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include UserSupport
  include BackgroundSupport
  include GithubSupport

  before_filter :set_github_grabber_host

  def root
    if user_signed_in?
      redirect_to projects_url
    end
  end
end
