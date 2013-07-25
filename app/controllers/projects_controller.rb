class ProjectsController < ApplicationController

  DEFAULT_FILTER = :idea

  include ProjectSupport

  before_filter :sign_in_required
  before_filter :has_project, :only => [:show, :edit, :update, :destroy]

  def index
    if params[:tag].present?
      @tag = Tag.where(:name => params[:tag]).first
      @projects = @tag.projects.latest_first if @tag
    else
      @filter = (params[:filter].presence || DEFAULT_FILTER).to_sym
      case(@filter)
        when :all then @projects = Project
        when :mine then @projects = current_user.projects
        else @projects = Project.where(:status => @filter)
      end
    end
    @projects = @projects.latest_first
  end

  def show
    @post = current_project.posts.build
  end

  def new
    @project = Project.new
    @initial_post = @project.posts.build
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
    params[:project][:posts_attributes].each { |post| post[:user] = current_user }
    params.require(:project).permit([:title, :subtitle, :demo_url, :repo_url, :posts_attributes => [:text, :user] ])
  end

end
