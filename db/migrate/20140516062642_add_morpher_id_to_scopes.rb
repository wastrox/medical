class AddMorpherIdToScopes < ActiveRecord::Migration
  def change
    add_column :scopes, :morpher_id, :integer
  end
end
