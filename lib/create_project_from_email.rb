class CreateProjectFromEmail
  def self.create(email_data)
    if User.exists?(email: email_data.from_email)
      user = User.where(email: email_data.from_email).first
      title = email_data.subject
      subtitle = email_data.text_body.split("\n").first
      project = Project.new(title: title, subtitle: subtitle)
      user.projects << project
      user.save!
      project
    end
  end
end