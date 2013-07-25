class RenameUpdateToUpdatedInPosts < ActiveRecord::Migration
  def change
    rename_column :posts, :update, :updated
  end
end
