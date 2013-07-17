class CreateKatas < ActiveRecord::Migration
  def change
    create_table :katas do |t|
      t.string :title
      t.string :subtitle
      t.string :repo_url
      t.string :demo_url
      t.string :status
      t.timestamps
    end
  end
end
