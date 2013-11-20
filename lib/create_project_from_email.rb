class CreateProjectFromEmail 
  def self.create(email_data)
    if User.exists?(email: email_data.from_email)
      user = User.where(email: email_data.from_email).first
      title = email_data.subject
      subtitle = email_data.text_body.split("\n").first
      post_text = email_data.text_body.split("\n").drop(1).join("\n")
      project = Project.new(title: title, subtitle: subtitle)
      project.posts << Post.new(text: post_text)
      user.projects << project
      user.save!
      project
    end
  end
end
