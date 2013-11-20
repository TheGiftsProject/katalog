require 'create_project_from_email'

class PostmarkController < ApplicationController
  def update
    email = Postmark::Mitt.new(request.body.read)
    CreateProjectFromEmail.create(email)
  end
end
