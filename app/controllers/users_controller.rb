class UsersController < ApplicationController

  include ProjectSupport

  before_action :sign_in_required
  before_action :project_required

  def destroy
    current_project.users.delete(selected_user)
    redirect_to current_project
  end


  private

  def selected_user
    User.find(params[:id])
  end

end