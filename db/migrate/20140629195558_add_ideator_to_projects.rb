class AddIdeatorToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :ideator_id, :integer
  end
end
