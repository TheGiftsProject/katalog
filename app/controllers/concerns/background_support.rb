module BackgroundSupport
  extend ControllerSupport::Base

  DEFAULT = 'landing'

  helper_method :background

  def set_background(type)
    @background = type
  end

  def background
    @background.presence || DEFAULT
  end

end