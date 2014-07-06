module ProjectHelper

  def new_for_current_user?(project)
    project.less_than_week_old? and not viewed_by_current_user?(project)
  end

  def viewed_by_current_user?(project)
    viewed_hash = cookies[:viewed]
    return false unless viewed_hash
    JSON.parse(viewed_hash)[project.id.to_s]
  end

  def status_icon(project)
    status = project.status if project.respond_to? :status
    content_tag :i, nil, :class => [icon_class(status), 'fa']
  end

  private

  def icon_class(status)
    {
      :idea    => 'fa-lightbulb-o',
      :lifted  => 'fa-paper-plane',
    }[status]
  end

end