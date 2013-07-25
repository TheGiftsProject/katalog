class AddProjectWebsiteUrl < ActiveRecord::Migration
  def change
    add_column :projects, :website_url, :string
  end
end
