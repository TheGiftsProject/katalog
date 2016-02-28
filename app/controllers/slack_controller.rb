class SlackController < ActionController::Base

  include ProjectSupport

  def create
    @user = User.joins(:organizations).where(organizations: {slack_token: params[:token]}, slack_id: params[:user_id]).first
    unless @user
      render inline: "Hey, welcome to Katalog. I don't know who you are please go to #{root_url}auth/slack and sign in"
      return
    end
    project = ProjectFromSlack.new.create_project @user, params[:text]
    render inline: "Done created project - #{projects_url(project)}"
  end


end