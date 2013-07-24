module IconHelper

  def status_icon(status)
    status = status.status if status.respond_to? :status
    content_tag :i, nil, :class => [icon_class(status), 'status-icon']
  end

  def icon_class(status)
    {
      :idea => 'icon-lightbulb',
      :wip  => 'icon-cogs',
      :done => 'icon-check-sign', #icon-sun ,
      :dead => 'icon-archive',
    }[status]
  end
end