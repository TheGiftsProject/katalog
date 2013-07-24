module LayoutHelper
  def blank_page?
    current_page? root_path
  end
end