module UserSupport

  extend ControllerSupport::Base
  include ErrorSupport

  SESSION_KEY = :user

  helper_method :current_user, :user_signed_in?

  def current_user
    @_current_user ||= load_user
  end

  def user_signed_in?
    current_user.present? && current_user.default_organization.present?
  end

  def sign_out
    session[SESSION_KEY] = nil
    @_current_user = nil
  end

  def sign_in(user)
    session[SESSION_KEY] = user.uid
    @_current_user = load_user
  end

  def current_organization
    current_user.default_organization
  end

  # before filters

  def sign_in_required
    forbidden unless user_signed_in?
  end

  private

  def load_user
    User.find_by_uid(session[SESSION_KEY])
  end

end