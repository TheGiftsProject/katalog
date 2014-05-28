class RemoveOldGithubStuff < ActiveRecord::Migration
  def change
    remove_column :projects, :last_commit_date
  end
end
