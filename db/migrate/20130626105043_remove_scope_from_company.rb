class RemoveScopeFromCompany < ActiveRecord::Migration
  def up
    remove_column :companies, :scope
  end

  def down
    add_column :companies, :scope, :string
  end
end
