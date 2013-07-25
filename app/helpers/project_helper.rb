module ProjectHelper

  def new_for_current_user?(project)
    project.less_than_week_old? and not viewed_by_current_user?(project)
  end

  private

  def viewed_by_current_user?(project)
    viewed_hash = cookies[:viewed]
    return false unless viewed_hash
    Rails.logger.info(viewed_hash)
    JSON.parse(viewed_hash)[project.id.to_s]
  end

end