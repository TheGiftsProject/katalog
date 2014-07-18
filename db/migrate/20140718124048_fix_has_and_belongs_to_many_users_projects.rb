class FixHasAndBelongsToManyUsersProjects < ActiveRecord::Migration
  def change
    remove_column :organizations_users, :id
    add_index(:organizations_users, [:organization_id, :user_id], :unique => true)
  end
end
