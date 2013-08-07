module User::GithubConcern
  extend ActiveSupport::Concern

  # Goes into User

  module ClassMethods

    # see: http://developer.github.com/v3/repos/collaborators/
    def find_or_init_by_contributor(contributor)
      User.where(:uid => contributor.id.to_s).first_or_initialize do |u|
        u.name = contributor.login
        u.nickname = contributor.login
        u.image = contributor.avatar_url

        # where is the email?! see: http://developer.github.com/v3/users/emails/
        #u.email = contributor.login
      end
    end

  end

end