module LayoutHelper
  def blank_page?
    current_page? root_path or params[:controller] == 'static'
  end
end