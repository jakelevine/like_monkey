class ChangeFollowingColumnFormat < ActiveRecord::Migration
  def up
  	change_column :users, :following, :text
  end

  def down
	change_column :users, :following, :string
  end
end
