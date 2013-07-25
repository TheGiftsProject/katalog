class AddProjectLastCommitDate < ActiveRecord::Migration
  def change
    add_column :projects, :last_commit_date, :datetime
  end
end
