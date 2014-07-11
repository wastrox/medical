class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :title
      t.text :description, null: false
      t.timestamps
    end
  end
end
