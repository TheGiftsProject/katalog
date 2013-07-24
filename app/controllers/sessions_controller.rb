class SessionsController < ApplicationController

  def create
    user = find_or_create_user_from_auth_hash(auth_hash)
    sign_in(user)
    redirect_to root_url
  end

  def failure
    flash[:error] = t('errors.sign_in')
    redirect_to root_url
  end

  protected

  def find_or_create_user_from_auth_hash(auth_hash)
    User.find_or
  end

  def auth_hash
    request.env['omniauth.auth']
  end

end