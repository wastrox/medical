class AddDeltaIndexToCompanies < ActiveRecord::Migration
  def change
  	add_index :companies, :delta
  end
end
