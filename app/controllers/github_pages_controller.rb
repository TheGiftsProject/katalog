require 'github_grabber'

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
    method = action_name
    @github_page_title = method.to_s
    @github_page = current_project.send(method)
    render 'projects/github_page'
  end

end