class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include UserSupport


  def root
    if user_signed_in?
      redirect_to projects_url
    end
  end

end
