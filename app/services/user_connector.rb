class UserConnector

  class UnsupportedProviderError < StandardError; end

  def self.connect_from_omniauth(auth_hash)
    case auth_hash.provider.to_sym
      when :github then UserConnector::GitHub.connect(auth_hash)
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

    def self.connect(auth_hash)
      ActiveRecord::Base.transaction do
        user = User.where(:uid => auth_hash.uid).first_or_create(:email    => auth_hash.info.email,
                                                                 :name     => auth_hash.info.name,
                                                                 :nickname => auth_hash.info.nickname,
                                                                 :image    => auth_hash.info.image)

        unless user.default_organization.present?
          organizations = Octokit::Client.new.organizations(user.nickname)
          Organization.where(:github_id => organizations)

          # todo merge with existing organizations of users and uniq
          # check what happens when deleting organization.
        end
      end
    end
  end

end