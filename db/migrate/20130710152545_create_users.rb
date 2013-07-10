class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   'name'
      t.string   'uid'
      t.string   'nickname'
      t.string   'image'
      t.string   'email'
      t.timestamps
    end
  end
end
