module ProjectSupport

  extend ControllerSupport::Base
  include ErrorSupport

  helper_method :current_project

  def current_project
    @_current_project ||= load_project
  end

  def set_current_project(project)
    @_current_project = project
  end

  def project_required
    forbidden if current_project.nil?
  end

  def scoped_projects
    current_user.default_organization.projects
  end

  private

  def load_project
    project_id = params[:project_id] || params[:id]
    Project.find(project_id.to_i)
  end

  # cookies

  def set_viewed_cookie
    project = @project || current_project
    return if project.new_record?
    return unless project.less_than_week_old?

    if cookies[:viewed]
      viewed_hash = JSON.parse(cookies[:viewed])
    else
      viewed_hash = {}
    end

    viewed_hash[project.id] = true
    cookies[:viewed] = {:value => viewed_hash.to_json, :expires => 1.week.from_now}
  end

  # referer

  def save_referer
    referer = request.referer
    return if referer.nil?

    # if came from a filtered index, save it.
    session[:referer] = referer if (referer['filter'])
  end

  def reset_referer
    session[:referer] = nil
  end

end