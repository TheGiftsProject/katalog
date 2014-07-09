class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :github_id
      t.timestamps
    end

    create_table :users_organizations do |t|
      t.belongs_to :organizations
      t.belongs_to :users
      t.timestamps
    end

    add_column :users, :default_organization, :integer
    add_column :projects, :organization_id, :integer
  end
end
