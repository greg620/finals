class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.string :username
      t.string :email
      t.integer :post_id
      t.integer :user_id
      t.integer :parent_id
      t.text :content

      t.timestamps
    end
  end
end
