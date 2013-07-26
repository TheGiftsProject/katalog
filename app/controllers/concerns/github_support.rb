require 'services/github_grabber'
require 'services/github_service_hook'

module GithubSupport
  extend ControllerSupport::Base

  include ProjectSupport

  GITHUB_PAGES = [:readme, :todo, :changelog]

  before_filter :set_github_grabber_host
  skip_before_filter :verify_authenticity_token, :only => [:post_receive_hook]
  before_filter :fetch_github_page, :only => GITHUB_PAGES

  GITHUB_PAGES.each do |github_page|
    define_method(github_page)
  end

  def post_receive_hook
    GithubServiceHook.new(params[:payload]).process_payload
  end
s
  def set_github_grabber_host
    GithubGrabber.hook_callback_url = project_github_service_hook_url(current_project)
  end

  private

  def fetch_github_page
    method = action_name
    @github_page_title = method.to_s.upcase
    @github_page = GithubGrabber.from_project(current_project).send(method)
    render 'projects/github_page'
  end

end