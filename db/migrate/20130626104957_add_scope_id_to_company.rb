class AddScopeIdToCompany < ActiveRecord::Migration
  def change
    add_column :companies, :scope_id, :integer
  end
end
