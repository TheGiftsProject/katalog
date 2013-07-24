class UserConnector

  class UserConnector::UnsupportedProviderError < StandardError; end

  def self.connect_from_omniauth(auth_hash)
    case auth_hash.provider.to_sym
      when :developer then UserConnector::OmniAuth::Developer.connect(auth_hash)
      when :github    then UserConnector::OmniAuth::GitHub.connect(auth_hash)
      else raise UnsupportedProviderError, auth_hash.provider
    end
  end

  module OmniAuth
    class Developer
      def self.connect(auth_hash)
        User.where(:uid => auth_hash.uid).first_or_create(:email => auth_hash.info.email,
                                                          :name  => auth_hash.info.name)
      end
    end

    class GitHub
      def self.connect(auth_hash)
        User.where(:uid => auth_hash.uid).first_or_create(:email    => auth_hash.info.email,
                                                          :name     => auth_hash.info.name,
                                                          :nickname => auth_hash.info.nickname,
                                                          :image    => auth_hash.info.image)
      end
    end
  end

end