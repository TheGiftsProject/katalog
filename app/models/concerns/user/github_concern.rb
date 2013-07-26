module User::GithubConcern
  extend ActiveSupport::Concern

  # Goes into User

  # see: http://developer.github.com/v3/repos/collaborators/
  def self.find_or_init_by_contributor(contributor)

    User.find_or_initialize_by(uid: contributor.id) do |u|
      u.name = contributor.login
      u.nickname = contributor.login
      u.image = contributor.avatar_url
      u.projects << self

      # where is the email?! see: http://developer.github.com/v3/users/emails/
      #u.email = contributor.login
    end
  end

end