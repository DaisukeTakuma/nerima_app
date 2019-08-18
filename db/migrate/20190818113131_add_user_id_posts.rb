class AddUserIdPosts < ActiveRecord::Migration[5.2]
  def up
    execute 'DELETE FROM posts;'
    add_reference :posts, :users, null: false, index: true
  end

  def down
    remove_reference :posts, :users, index: true
  end
end
