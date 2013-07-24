class SessionController < ApplicationController

  def create
    user = UserConnector.connect_from_omniauth(auth_hash)
    sign_in(user)
    redirect_to root_url
  end

  def failure
    flash[:error] = t('errors.sign_in')
    redirect_to root_url
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  protected

  def auth_hash
    request.env['omniauth.auth']
  end

end