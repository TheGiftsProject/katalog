module FilterHelper

  def current_filter?(filter)
    @filter.to_s == filter.to_s
  end

  def active_class_if_current(filter)
    if current_filter?(filter)
      {:class => :active}
    else
      {}
    end
  end

end