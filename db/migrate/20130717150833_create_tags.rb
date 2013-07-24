class CreateTags < ActiveRecord::Migration
  def change
    create_table :tags do |t|
      t.string :name
    end

    create_table :projects_tags do |t|
      t.belongs_to :project
      t.belongs_to :tag
    end
  end
end
