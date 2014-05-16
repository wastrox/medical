class AddMorpherIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :morpher_id, :integer
  end
end
