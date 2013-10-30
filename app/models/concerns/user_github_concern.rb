module UserGithubConcern
  extend ActiveSupport::Concern

  # Goes into User

  module ClassMethods

    # see: http://developer.github.com/v3/repos/collaborators/
    def find_by_contributor(contributor)
      User.where(:uid => contributor.id.to_s).first
    end

  end

end