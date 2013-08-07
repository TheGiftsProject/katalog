require 'github/repo_searcher'

class AutocompleteController < ApplicationController

  before_filter :sign_in_required
  before_action :load_query, :only => [:projects, :repositories]

  def tags
    render :json => Tag.all
  end

  def projects
    render :json => Project.search(@query).map do |project|
      {:value => project.title, :tokens => project.title.split(' ') }
    end
  end

  def repositories
    repos = if params[:latest] then repo_searcher.latest else repo_searcher.search(@query) end
    render :json => repos.to_json
  end

  private

  def load_query
    @query = params[:q]
    render :json => [] if @query.blank?
  end

  def repo_searcher
    @repo_search ||= Github::RepoSearcher.new
  end

end