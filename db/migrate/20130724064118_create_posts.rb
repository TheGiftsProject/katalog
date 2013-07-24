class CreatePosts < ActiveRecord::Migration

  def change
    create_table :posts do |t|
      t.belongs_to :project
      t.belongs_to :user
      t.string  :text,   :limit => 1024
      t.string  :story,  :default => :none
      t.boolean :update, :default => false
    end
  end

end
