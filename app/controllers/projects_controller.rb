class ProjectsController < ApplicationController

  include ProjectSupport

  before_filter :has_project, :only => [:show]

  def index
    @projects = Project.latest_first
  end

  def show

  end

end
