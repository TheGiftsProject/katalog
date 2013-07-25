class StaticController < ApplicationController

  def not_found
    render_error(404)
  end

  def forbidden
    render_error(403)
  end

  def internal_error
    render_error(500)
  end

  private

  def render_error(code)

    render :file => 'static/error', :locals => {:code => code}
  end
end