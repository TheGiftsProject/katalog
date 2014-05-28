class AutocompleteController < ApplicationController

  before_filter :sign_in_required
  before_action :load_query, :only => [:projects]

  def projects
    if @query.blank?
      render :json => []
    else
      render :json => Project.search(@query).map do |project|
        {:value => project.title, :tokens => project.title.split(' ') }
      end
    end
  end

  private

  def load_query
    @query = params[:q]
  end

end