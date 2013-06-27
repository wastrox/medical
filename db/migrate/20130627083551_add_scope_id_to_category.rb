class AddScopeIdToCategory < ActiveRecord::Migration
  def change
    add_column :categories, :scope_id, :integer
  end
end
