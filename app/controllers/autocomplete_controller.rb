class AutocompleteController < ApplicationController

  before_action :load_query, :only => [:projects]

  def tags
    render :json => Tag.all
  end

  def projects
    render :json => Project.search(@query).map do |project|
      {:value => project.title, :tokens => project.title.split(' ') }
    end
  end



  private

  def load_query
    @query = params[:q]
    render :json => [] if @query.blank?
  end


end