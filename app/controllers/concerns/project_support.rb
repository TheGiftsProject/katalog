module ProjectSupport

  extend ControllerSupport::Base
  include ErrorSupport
  include BackgroundSupport

  helper_method :current_project

  def current_project
    @_current_project ||= load_project
  end

  def set_current_project(project)
    @_current_project = project
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
    session[:referer] = referer if (referer['tag'] || referer['filter'])
  end

  def reset_referer
    session[:referer] = nil
  end

end