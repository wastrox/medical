class AddDeltaIndexToAccounts < ActiveRecord::Migration
  def change
  	add_index :accounts, :delta
  end
end
