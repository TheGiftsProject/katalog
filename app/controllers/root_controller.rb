class RootController < ApplicationController

  def index
    if user_signed_in?
      redirect_to projects_url
    else
      render :template => 'pages/sign_in'
    end
  end

end
