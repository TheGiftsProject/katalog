class ProjectFromSlack
  def create_project(user, text)
    project = Project.new(title: text, subtitle: nil, ideator: user, organization_id: user.default_organization.id)
    user.projects << project
    user.save!
    project
  end
end