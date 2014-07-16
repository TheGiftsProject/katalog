class CreateOrganizations < ActiveRecord::Migration
  def change
    create_table :organizations do |t|
      t.string :name
      t.string :github_id
      t.timestamps
    end

    create_table :organizations_users do |t|
      t.integer :organization_id
      t.integer :user_id
      t.timestamps
    end

    add_column :users, :default_organization_id, :integer
    add_column :projects, :organization_id, :integer
  end
end
