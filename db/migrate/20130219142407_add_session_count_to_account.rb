class AddSessionCountToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :session_count, :integer, :default => 0
  end
end
