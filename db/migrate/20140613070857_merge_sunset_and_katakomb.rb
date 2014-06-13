class MergeSunsetAndKatakomb < ActiveRecord::Migration
  def change
    Project.where(:status => :dead).find_each(&:done!)
  end
end
