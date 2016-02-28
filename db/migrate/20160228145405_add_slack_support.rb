class AddSlackSupport < ActiveRecord::Migration
  def change
    add_column :organizations, :slack_token, :string
    add_column :users, :slack_id, :string
  end
end
