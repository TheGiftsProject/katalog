class MergeSunsetAndKatakomb < ActiveRecord::Migration
  def up
    execute "UPDATE projects SET status='lifted' WHERE status != 'idea'"
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
