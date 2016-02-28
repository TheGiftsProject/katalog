class SlackController < ActionController::Base

  include UserSupport
  include ProjectSupport


  layout 'application'
  before_action :sign_in_required, only: [:show]
  def show
  end

  def create
    @user = User.joins(:organizations).where(organizations: {slack_token: params[:token]}, slack_id: params[:user_id]).first
    unless @user
      render inline: "Hey, welcome to Katalog. I don't know who you are please go to <#{root_url}slack> and sign in."
      return
    end
    project = ProjectFromSlack.new.create_project @user, params[:text]
    render inline: "Done created your new project -> <#{projects_url(project)}>"
  end


end