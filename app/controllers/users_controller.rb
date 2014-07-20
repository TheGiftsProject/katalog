class UsersController < ApplicationController

  include ProjectSupport

  before_action :sign_in_required
  before_action :project_required

  before_action :destroy_validations, only: [:destroy]

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
    current_project.users.find(params[:id])
  end

  def destroy_validations
    redirect_to :back, alert: 'Unknown User' and return if selected_user.nil?
    redirect_to :back, alert: 'Can\'t remove the ideator' and return if selected_user == current_project.ideator
    redirect_to :back, alert: 'Can\'t remove all the users' and return if current_project.users.count == 1
  end

end