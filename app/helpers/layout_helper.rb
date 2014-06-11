module LayoutHelper
  def headless_page?
    current_page? root_path or params[:controller] == 'static' or @no_background
  end

  def container_class
    headless_page? ? 'headless' : 'full'
  end
end