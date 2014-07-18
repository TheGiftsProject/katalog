class AutocompleteController < ApplicationController

  include ProjectSupport
  before_filter :sign_in_required
  before_action :load_query, :only => [:projects]

  def projects
    render json: found_projects, each_serializer: Autocomplete::ProjectSerializer, root: false
  end

  def users
    render json: User.all, each_serializer: Autocomplete::UserSerializer, root: false
  end

  def found_projects
    scoped_projects.search(@query)
  end

  private

  def load_query
    @query = params.require(:q)
  end

end