class MergeSunsetAndKatakomb < ActiveRecord::Migration
  def up
    execute "UPDATE projects SET status = 'lifted' WHERE status = 'wip'"
    execute "UPDATE projects SET status = 'lifted' WHERE status = 'done'"
    execute "UPDATE projects SET status = 'lifted' WHERE status = 'dead'"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
