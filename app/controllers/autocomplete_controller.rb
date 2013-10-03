require 'github/repo_searcher'

class AutocompleteController < ApplicationController

  before_filter :sign_in_required
  before_action :load_query, :only => [:projects, :repositories]

  def projects
    if @query.blank?
      render :json => []
    else
      render :json => Project.search(@query).map do |project|
        {:value => project.title, :tokens => project.title.split(' ') }
      end
    end
  end

  def repositories
    repos = if params[:latest] then repo_searcher.latest else repo_searcher.search(@query) end
    render :json => repos.to_json
  end

  private

  def load_query
    @query = params[:q]
  end

  def repo_searcher
    @repo_search ||= Github::RepoSearcher.new
  end

end