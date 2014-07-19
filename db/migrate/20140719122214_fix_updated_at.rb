class FixUpdatedAt < ActiveRecord::Migration
  def up
    Project.find_each do |project|
      last_post = project.posts.last
      project.update(:updated_at => last_post.created_at) if last_post.present?
    end
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
