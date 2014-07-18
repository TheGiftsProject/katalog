class PostmarkController < ActionController::Base

  def update
    request.body.rewind
    email = Postmark::Mitt.new(request.body.read)
    ProjectFromEmail.create(email)
    render :nothing => true
  end
end