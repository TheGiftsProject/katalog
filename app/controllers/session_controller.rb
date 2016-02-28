class SessionController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def create
    if params[:provider] == 'slack'
      set_error_flash('Must be already signed in') and return unless user_signed_in?
      current_user.update(slack_id: auth_hash.uid)
      return
    end

    response = UserConnector.connect_from_omniauth(auth_hash)
    sign_in_with_connection_response(response)
  rescue => error
    set_error_flash(error)
  ensure
    redirect_to_root
  end

  def organization
    response = UserConnector.connect_organization_to_user(params[:org_id], current_user)
    sign_in_with_connection_response(response)
  rescue => error
    set_error_flash(error)
  ensure
    redirect_to_root
  end

  def change_organization
    current_user.update!(:default_organization_id => nil)
    redirect_to sign_in_path
  end

  def destroy
    sign_out
    redirect_to_root
  end

  def failure
    set_error_flash
    redirect_to_root
  end

  protected

  def sign_in_with_connection_response(response)
    sign_in(response.user)
    session[:organizations] = response.organizations if response.requires_organization?
  end

  def redirect_to_root()
    redirect_to root_url(:port => nil)
  end

  def set_error_flash(error)
    Rails.logger.error(error)
    flash[:error] = t('session.sign_in_error')
  end

  def auth_hash
    request.env['omniauth.auth']
  end

end