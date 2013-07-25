class RemoveStories < ActiveRecord::Migration
  def change
    remove_column :posts, :story
  end
end
