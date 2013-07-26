class ProjectsController < ApplicationController

  DEFAULT_FILTER = :idea

  include ProjectSupport
  include GithubSupport

  before_filter :sign_in_required
  before_filter :has_project, :only => [:show, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:show]
  before_filter :reset_referer, :only => [:index]
  after_filter :set_viewed_cookie, :only => [:create, :show]

  def index
    if params[:tag].present?
      @tag = Tag.find_caseless(params[:tag]).first
      if @tag
        @projects = @tag.projects.latest_first
      else
        @projects = []
      end
    else
      @filter = (params[:filter].presence || DEFAULT_FILTER).to_sym
      case(@filter)
        when :all then @projects = Project.latest_first
        when :mine then @projects = current_user.projects.latest_first
        else @projects = Project.where(:status => @filter).latest_first
      end
    end
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
    params.require(:project).permit([:title, :subtitle, :demo_url, :repo_url, :string_tags => [], :posts_attributes => [:text]])
  end

  def build_project
    project = current_user.projects.build(project_params)
    project.posts.first.user = current_user
    project
  end

end
