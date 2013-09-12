class AddDescriptionToScope < ActiveRecord::Migration
  def change
    add_column :scopes, :description, :text
  end
end
