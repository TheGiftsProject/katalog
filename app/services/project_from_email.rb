class ProjectFromEmail
  def self.create(email_data)
    if User.exists?(email: email_data.from_email)
      user = User.where(email: email_data.from_email).first
      return nil if user.organization_id

      title = email_data.subject
      subtitle = email_data.text_body.split("\n").first
      project = Project.new(title: title, subtitle: subtitle, ideator: user, organization_id: user.default_organization)
      user.projects << project
      user.save!
      project
    end
  end
end