class ProjectsController < ApplicationController

  DEFAULT_FILTER = :all

  include ProjectSupport
  include LikeSupport

  before_filter :sign_in_required
  before_filter :project_required, :only => [:show, :edit, :update, :destroy]
  before_filter :save_referer, :only => [:show]
  before_filter :reset_referer, :only => [:index]
  before_filter :random_idea, only: [:index, :mine, :sync, :ideas, :lifted, :user]
  after_filter :set_viewed_cookie, :only => [:create, :show]

  def index
    set_projects_for_scope(scoped_projects)
  end

  def mine
    set_projects_for_scope(scoped_projects.of_user(current_user))
    render action: :index
  end

  def lifted
    set_projects_for_scope(scoped_projects.lifted)
    render action: :index
  end

  def ideas
    set_projects_for_scope(scoped_projects.idea)
    render action: :index
  end

  def user
    @user = current_organization.users.find_by(nickname: params[:username])
    redirect_to root_path and return unless @user.present?
    set_projects_for_scope(scoped_projects.of_user(@user))
    render action: :index
  end

  def sync
    seed = Time.now.beginning_of_day.to_i
    rand = Random.new(seed)
    @user_projects = users_projects.shuffle(:random => rand)
  end

  def random
    random_idea
    render partial: 'projects/index/random_idea', layout: false
  end

  #########

  def show
    @post = current_project.posts.build
  end

  def create
    @project = build_project
    if @project.save
      set_current_project(@project)
      redirect_to :back, notice: t('notices.created')
    else
      flash[:error] = @project.errors.full_messages.join(', ')
      redirect_to :back
    end
  end

  def edit
  end

  def lift
    current_project.lift!
    redirect_to current_project, notice: t('notices.lifted')
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

  def like
    if likes_current_project?
      unlike_current_project
    else
      like_current_project
    end

    redirect_to :back
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
    project.users = [current_user]
    project.ideator_id = current_user.id
    project.organization_id = current_user.default_organization_id
    project
  end

  def set_projects_for_scope(scope)
    @projects = scope.latest_first.paginate(:page => params[:page])
  end

  def random_idea
    @random_project = scoped_projects.idea.to_a.sample
  end

  def users_projects
    users_projects = current_organization.users.map do |user|
      projects = scoped_projects.of_user(user).latest_first.limit(3)
      [user, projects.presence]
    end
    users_projects.delete_if { |arr| arr.second.blank? }
    users_projects.sort_by {|arr| arr.second.first.updated_at }.reverse
  end

end
