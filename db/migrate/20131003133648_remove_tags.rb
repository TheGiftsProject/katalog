class RemoveTags < ActiveRecord::Migration
  def change
    drop_table :projects_tags
    drop_table :tags
  end
end
