class CreateKatas < ActiveRecord::Migration
  def change
    create_table :katas do |t|
      t.string   'name'
      t.timestamps
    end
  end
end
