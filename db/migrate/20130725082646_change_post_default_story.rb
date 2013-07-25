class ChangePostDefaultStory < ActiveRecord::Migration
  def up
    change_column :posts, :story, :string, :default => :nothing
    execute "UPDATE posts SET story='nothing' WHERE story='none'"
  end

  def down
    change_column :posts, :story, :string, :default => :none
    execute "UPDATE posts SET story='none' WHERE story='nothing'"
  end
end
