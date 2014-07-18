class AutocompleteController < ApplicationController

  before_filter :sign_in_required
  before_action :load_query, :only => [:projects]

  def projects
    render json: found_projects, each_serializer: Autocomplete::ProjectSerializer, root: false
  end

  def found_projects
    Project.search(@query)
  end

  private

  def load_query
    @query = params[:q]
  end

end