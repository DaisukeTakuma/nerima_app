class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.text :summary
      t.text :description
      t.text :url

      t.timestamps
    end
  end
end
