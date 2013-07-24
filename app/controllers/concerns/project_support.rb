module ProjectSupport

  extend ControllerSupport::Base
  include ErrorSupport
  include BackgroundSupport

  helper_method :current_project

  def current_project
    @_current_project ||= load_project
  end

  def has_project
    forbidden if current_project.nil?
    set_background(current_project.status)
  end

  private

  def load_project
    project_id = params[:project_id] || params[:id]
    Project.find(project_id.to_i)
  end
end