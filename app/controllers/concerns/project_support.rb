module ProjectSupport

  extend ControllerSupport::Base
  include ErrorSupport

  helper_method :current_project

  def current_project
    @_current_project ||= load_project
  end

  def has_project
    forbidden if current_project.nil?
  end

  private

  def load_project
    project_id = params[:project_id] || params[:id]
    Project.find(project_id.to_i)
  end
end