class UserConnector

  class UnsupportedProviderError < StandardError; end

  def self.connect_from_omniauth(auth_hash)
    case auth_hash.provider.to_sym
      when :developer then UserConnector::Developer.connect(auth_hash)
      when :github    then UserConnector::GitHub.connect(auth_hash)
      else raise UnsupportedProviderError, auth_hash.provider
    end
  end

  class Developer
    def self.connect(auth_hash)
      User.where(:uid => auth_hash.uid).first_or_create(:email => auth_hash.info.email,
                                                        :name  => auth_hash.info.name)
    end
  end

  class GitHub

    class UnauthorizedGithubUser < StandardError; end

    def self.connect(auth_hash)
      raise UnauthorizedGithubUser unless authorized?(auth_hash.uid)

      User.where(:uid => auth_hash.uid).first_or_create(:email    => auth_hash.info.email,
                                                        :name     => auth_hash.info.name,
                                                        :nickname => auth_hash.info.nickname,
                                                        :image    => auth_hash.info.image)
    end

    def self.authorized?(uid)
      members = Octokit.organization_members(ENV['AUTHORIZED_GITHUB_ORGANIZATION'])
      members.find { |member| member.id.to_s == uid }
    end
  end

end