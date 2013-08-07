require 'github/grabber'

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

  #private

  def setup_github_page
    @github_page_title = action_name.to_s
    @github_page = current_project.send("github_#{action_name}")
    render 'projects/github_page'
  end

end