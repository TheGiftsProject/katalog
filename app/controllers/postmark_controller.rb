require 'create_project_from_email'

class PostmarkController < ActionController::Base

  def update
    Rails.logger.info("Incoming post from postmark")
    email = Postmark::Mitt.new(request.body.read)
    CreateProjectFromEmail.create(email)
    render :nothing => true
  end
end
