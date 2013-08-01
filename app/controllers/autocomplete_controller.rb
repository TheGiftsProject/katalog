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
    render :json => Github::RepoSeach.new.search(@query).to_json
  end

  private

  def load_query
    @query = params[:q]
    render :json => [] if @query.blank?
  end


end