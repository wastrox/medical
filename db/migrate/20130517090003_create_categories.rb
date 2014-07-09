class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :title
      t.text :description, default: "No description"
      t.timestamps
    end
  end
end
