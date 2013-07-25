module ProjectHelper

  def new_for_current_user?(project)
    project.less_than_week_old? and not viewed_by_current_user?(project)
  end

  private

  def viewed_by_current_user?(project)
    viewed_hash = cookies[:viewed]
    return false unless viewed_hash
    JSON.parse(viewed_hash)[project.id.to_s]
  end

  def back_to_index_url
    session[:referer] || projects_path
  end

end