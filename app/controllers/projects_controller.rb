require 'github/syncer'

class ProjectsController < ApplicationController

  DEFAULT_FILTER = :recent

  include ProjectSupport
  include GithubSupport

  before_filter :sign_in_required
  before_filter :has_project, :only => [:show, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:show]
  before_filter :reset_referer, :only => [:index]
  after_filter :set_viewed_cookie, :only => [:create, :show]
  before_filter :set_github_grabber_host, :only => [:update, :destroy]

  def index
    filter_by_status
  end

  def show
    @post = current_project.posts.build
  end

  def new
    @project = Project.new
    @initial_post = @project.posts.build
  end

  def create
    @project = build_project
    if @project.save
      set_current_project(@project)
      set_github_grabber_host
      github_syncer.creation_sync
      redirect_to @project, notice: t('notices.created')
    else
      flash[:error] = @project.errors.full_messages.join(', ')
      redirect_to new_project_path
    end
  end

  def edit

  end

  def update
    if current_project.update(project_params)
      github_syncer.update_sync
      redirect_to current_project, notice: t('notices.updated')
    else
      render action: 'edit'
    end
  end

  def destroy
    github_syncer.destruction_sync
    current_project.destroy
    redirect_to projects_path, notice: t('notices.destroyed')
  end

  def bump
    current_project.touch
    redirect_to current_project, notice: t('notices.bumped')
  end

  def contribute
    add_user_to_project
    redirect_to current_project, notice: t('notices.contribute')
  end

  private

  def add_user_to_project
    current_project.users << current_user unless current_project.users.include? current_user
  end


  def project_params
    params.require(:project).permit([:title, :subtitle, :demo_url, :repo_url, :posts_attributes => [:text]])
  end

  def build_project
    project = current_user.projects.build(project_params)
    project.posts.first.user = current_user
    project.users = [current_user]
    project
  end

  def github_syncer
    @github_syncer ||= Github::Syncer.new(current_project)
  end

  def filter_by_status
    @filter = (params[:filter].presence || DEFAULT_FILTER).to_sym
    case (@filter)
      when :all then
        @projects = Project.not_dead.not_done.latest_first
      when :recent then
        @projects = Project.not_dead.latest_first.recent
      when :mine then
        @projects = current_user.projects.latest_first
      else
        @projects = Project.where(:status => @filter).latest_first
    end
  end

end
