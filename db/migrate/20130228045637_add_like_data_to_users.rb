class AddLikeDataToUsers < ActiveRecord::Migration
  def change
    add_column :users, :following_likes, :text, :limit => nil
  end
end
