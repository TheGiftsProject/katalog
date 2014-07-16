require 'hashie'

class UserConnector

  class InvalidOrganizationError < StandardError; end

  def self.connect_from_omniauth(auth_hash)
    user = user_from_auth_hash(auth_hash)

    if user.default_organization.present?
      ConnectionResponse.new(:user => user)
    else
      organizations = user_organizations(user)
      organizations.map! { |org| {:name => org[:login], :id => org[:id]} }
      ConnectionResponse.new(:user => user, :organizations => organizations)
    end
  end

  def self.connect_organization_to_user(org_id, user)
    organizations = user_organizations(user)
    matching_org = organizations.find { |org| org[:login] = org_id }

    raise InvalidOrganizationError if matching_org.nil?

    organization = Organization.where(:github_id => org_id).first_or_create(:name => matching_org[name])
    user.organizations << organization
    user.update!(:default_organization_id => organization.id)


  end

  def self.user_from_auth_hash(auth_hash)
    User.where(:uid => auth_hash.uid).first_or_create(:email    => auth_hash.info.email,
                                                      :name     => auth_hash.info.name,
                                                      :nickname => auth_hash.info.nickname,
                                                      :image    => auth_hash.info.image)
  end

  def self.user_organizations(user)
    Octokit::Client.new.organizations(user.nickname)
  end

  class ConnectionResponse < Hashie::Dash
    property :user, :require => true
    property :organizations

    def requires_organization?
      user.default_organization.nil?
    end
  end

end