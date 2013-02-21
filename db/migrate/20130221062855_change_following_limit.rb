class ChangeFollowingLimit < ActiveRecord::Migration
  def up
	change_column :users, :following, :text, :limit => nil
  end

  def down
  end
end
