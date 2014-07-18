class AddLiftedAtToProject < ActiveRecord::Migration
  def change
    add_column :projects, :lifted_at, :datetime

    Project.find_each do |project|
      current_lifted_at = project.posts.where(updated: true).minimum(:created_at)
      if current_lifted_at
        project.update(lifted_at: current_lifted_at)
      end
    end
  end
end
