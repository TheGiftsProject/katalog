require 'create_project_from_email'

class PostmarkController < ActionController::Base

  def update
    request.body.rewind
    email = Postmark::Mitt.new(request.body.read)
    CreateProjectFromEmail.create(email)
    render :nothing => true
  end
end