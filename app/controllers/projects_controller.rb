class ProjectsController < ApplicationController

  include ProjectSupport

  before_filter :has_project, :only => [:show, :edit, :update, :destroy]

  def index
    @projects = Project.latest_first
  end

  def show

  end

  def new
    @project = Project.new
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to @project, notice: t('notices.created')
    else
      render action: 'new'
    end
  end

  def edit

  end

  def update
    if current_project.update(project_params)
      redirect_to current_project, notice: t('notices.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    current_project.destroy
    redirect_to projects_path, notice: t('notices.destroyed')
  end

  private

  def project_params
    params.require(:project).permit([:title, :subtitle, :demo_url, :repo_url])
  end

end
