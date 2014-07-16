class SessionController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    response = UserConnector.connect_from_omniauth(auth_hash)
    sign_in_with_connection_response(response)
  rescue
    flash[:error] = t('.sign_in_error')
  ensure
    redirect_to root_url(:port => nil)
  end

  def organization
    response = UserConnector.connect_organization_to_user(params[:org_id], current_user)
    sign_in_with_connection_response(response)
  rescue
    flash[:error] = t('.sign_in_error')
  ensure
    redirect_to root_url(:port => nil)
  end

  def destroy
    sign_out
    redirect_to root_url
  end

  def failure
    flash[:error] = t('errors.sign_in')
    redirect_to root_url
  end

  protected

  def sign_in_with_connection_response(response)
    sign_in(response.user)
    session[:organizations] = response.organizations if response.requires_organization?
  end

  def auth_hash
    request.env['omniauth.auth']
  end

end