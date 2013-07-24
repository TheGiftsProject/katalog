module BackgroundSupport
  extend ControllerSupport::Base

  DEFAULT = 'landing'

  helper_method :background_class

  def set_background(type)
    @background = type
  end

  def background
    @background.presence || DEFAULT
  end

  def background_class
    {:class => background}
  end

end