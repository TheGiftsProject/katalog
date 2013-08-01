module LayoutHelper
  def blank_page?
    current_page? root_path or params[:controller] == 'static' or @no_background
  end
end