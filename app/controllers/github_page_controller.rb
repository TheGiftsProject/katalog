require 'services/github_grabber'

class GithubPageController < ProjectsController

  include ProjectSupport

  GITHUB_PAGES = [
      :readme,
      :todo,
      :changelog
  ]

  before_filter :setup_github_page, :only => GITHUB_PAGES

  # create an action for each page
  GITHUB_PAGES.each do |github_page|
    define_method(github_page)
  end

  private

  def setup_github_page
    method = action_name
    @github_page_title = method.to_s.upcase
    @github_page = GithubGrabber.from_project(current_project).send(method)
    render 'projects/github_page'
  end

end