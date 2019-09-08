class AddPostIdToComments < ActiveRecord::Migration[5.2]
  def change
    add_reference :comments, :post, index: true, null: false
  end
end
