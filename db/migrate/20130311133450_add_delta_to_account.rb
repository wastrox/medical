class AddDeltaToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :delta, :boolean, :default => true,
    :null => false
  end
end
