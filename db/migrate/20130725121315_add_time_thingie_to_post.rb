class AddTimeThingieToPost < ActiveRecord::Migration
  def change
    change_table :posts do |t|
      t.timestamps
    end
  end
end
