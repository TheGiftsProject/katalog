class CreateProjectUpdates < ActiveRecord::Migration
  def change
    create_table :project_updates do |t|
      t.belongs_to :user
      t.belongs_to :project
      t.datetime :updated_at
    end
  end
end
