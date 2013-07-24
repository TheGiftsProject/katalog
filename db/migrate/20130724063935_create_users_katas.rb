class CreateUsersKatas < ActiveRecord::Migration
  def change
    create_table :users_katas do |t|
      t.belongs_to :kata
      t.belongs_to :user
    end
  end
end
