class AddFollowingList < ActiveRecord::Migration
	def up
	  execute "create extension hstore"
	  add_column :table, :column, :hstore
	end

	def down
	  remove_column :table, :column
	end
end
