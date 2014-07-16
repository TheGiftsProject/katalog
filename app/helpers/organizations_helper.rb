module OrganizationsHelper

  def options_for_organizations(organizations)
    organizations.map { |org| [org[:name], org[:id]] }
  end

end