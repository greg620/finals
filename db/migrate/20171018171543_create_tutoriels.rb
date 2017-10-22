class CreateTutoriels < ActiveRecord::Migration[5.1]
  def change
    create_table :tutoriels do |t|
      t.string :title
      t.string :slug
      t.integer :user_id
      t.text :content
      t.string :thumb

      t.timestamps
    end
  end
end
