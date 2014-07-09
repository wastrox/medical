class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :title
      t.text :description, default: "No description"
      t.timestamps
    end
  end
end
