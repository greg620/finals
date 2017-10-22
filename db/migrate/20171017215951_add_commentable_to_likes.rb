class AddCommentableToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :commentable, :string, default: 'post'
  end
end
