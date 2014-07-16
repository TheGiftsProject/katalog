require 'hashie'

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
      user = User.where(:uid => auth_hash.uid).first_or_create(:email    => auth_hash.info.email,
                                                               :name     => auth_hash.info.name,
                                                               :nickname => auth_hash.info.nickname,
                                                               :image    => auth_hash.info.image)

      organizations = Octokit::Client.new.organizations(user.nickname) unless user.default_organization.present?

      ConnectionResponse.new(:user => user, :organizations => organizations)

    end

    class ConnectionResponse < Hashie::Dash
      property :user, :require => true
      property :organizations

      def requires_organization?
        user.default_organization.nil?
      end
    end

  end

end