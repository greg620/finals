class AddFieldCategoryIdToTutoriels < ActiveRecord::Migration[5.1]
  def change
    add_column :tutoriels, :category_id, :integer
  end
end
