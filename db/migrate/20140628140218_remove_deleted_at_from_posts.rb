class RemoveDeletedAtFromPosts < ActiveRecord::Migration
  def change
    remove_column :posts, :deleted_at
  end
end
