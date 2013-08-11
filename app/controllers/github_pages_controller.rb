require 'github/page'

class GithubPagesController < ApplicationController

  include ProjectSupport

  GITHUB_PAGES = [
    :readme,
    :todo,
    :changelog
  ]

  # create an action for each page
  GITHUB_PAGES.each do |github_page|
    define_method(github_page) do
      setup_github_page
    end
  end

  def github_page
    @github_page ||= Github::Page.new(current_project)
  end

  private

  def setup_github_page
    @github_page_title = action_name.to_s
    begin
      @github_page_content = self.github_page.send(action_name)
      render 'projects/github_page'
    rescue Github::Page::FileNotFoundError
      render 'projects/github_page_not_found'
    rescue Github::Page::InvalidProjectError
      redirect_to project_path(current_project)
    end
  end

end