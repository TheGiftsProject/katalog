class CreateProjectFromEmail 
  def self.create(email_data)
    if User.exists?(email: email_data.from_email)
      Project.create(title: email_data.subject, subtitle: email_data.text_body)
    end
  end
end
