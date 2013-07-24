class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :title
      t.string :subtitle
      t.string :repo_url
      t.string :demo_url
      t.string :status, :default => :idea
      t.timestamps
    end
  end
end
