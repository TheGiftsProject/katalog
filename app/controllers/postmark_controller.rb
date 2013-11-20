require 'create_project_from_email'

class PostmarkController < ApplicationController

  skip_before_filter :verify_authenticity_token

  def update
    Rails.logger.info("Incoming post from postmark")
    Rails.logger.info(request.body.read)
    email = Postmark::Mitt.new(request.body.read)
    CreateProjectFromEmail.create(email)
    render :nothing => true
  end
end
