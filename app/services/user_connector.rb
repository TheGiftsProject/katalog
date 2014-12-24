require 'hashie'

class UserConnector

  class InvalidOrganizationError < StandardError; end

  def self.connect_from_omniauth(auth_hash)
    user = user_from_auth_hash(auth_hash)

    if user.default_organization.present?
      ConnectionResponse.new(:user => user)
    else
      organizations = user_organizations(user)
      if organizations.count == 1
        org = organizations.first
        set_default_organization(user, org[:id], org[:login])
        ConnectionResponse.new(:user => user)
      else
        organizations.map! { |org| {:name => org[:login], :id => org[:id]} }
        ConnectionResponse.new(:user => user, :organizations => organizations)
      end
    end
  end

  def self.connect_organization_to_user(org_id, user)
    organizations = user_organizations(user)
    matching_org = organizations.find { |org| org[:id] = org_id.to_s }

    raise InvalidOrganizationError if matching_org.nil?

    set_default_organization(user, org_id, matching_org[:login])
    ConnectionResponse.new(:user => user)
  end

  private

  def self.set_default_organization(user, org_id, org_name)
    organization = Organization.where(:github_id => org_id.to_s).first_or_create(:name => org_name)
    user.organizations << organization unless user.organizations.include?(organization)
    user.update!(:default_organization_id => organization.id)
  end

  def self.user_from_auth_hash(auth_hash)
    user = User.find_or_initialize_by(:uid => auth_hash.uid)
    user.update!(:email    => auth_hash.info.email,
                 :nickname => auth_hash.info.nickname,
                 :image    => auth_hash.info.image)
    user.update!(:name     => auth_hash.info.name) if user.name.nil?
    user
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