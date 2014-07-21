module ApplicationHelper

  def headless_page?
    current_page? root_path or params[:controller] == 'static' or @no_background
  end

  def class_if(klass, condition)
    if condition
      {:class => klass}
    else
      {}
    end
  end
end
