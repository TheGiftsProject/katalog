class UsersController < ApplicationController

  include ProjectSupport

  before_action :sign_in_required
  before_action :project_required

  def create
    current_project.users << current_user
    current_user.save
    redirect_to current_project
  end

  def destroy
    current_project.users.delete(selected_user)
    redirect_to current_project
  end

  private

  def selected_user
    User.find(params[:id])
  end

end