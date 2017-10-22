class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :slug
      t.boolean :user_id
      t.text :content

      t.timestamps
    end
  end
end
