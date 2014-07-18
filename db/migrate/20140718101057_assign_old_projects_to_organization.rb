class AssignOldProjectsToOrganization < ActiveRecord::Migration
  def up
    org = Organization.where(:github_id => '5079491').first_or_create(:name => 'iic-ninjas')
    Project.update_all(:organization_id => org.id)
  end

  def down
    Project.update_all(:organization_id => nil)
  end
end
