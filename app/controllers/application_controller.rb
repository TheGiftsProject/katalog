class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  include UserSupport
  include MarkdownSupport

  def root
    if user_signed_in?
      redirect_to projects_url
    else
      @organizations = session.delete(:organizations)
      flash[:errror] = t('pages.root.no_orgs')# if !@organizations.nil? && @organizations.blank?
    end
  end
end
