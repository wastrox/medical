class AddSessionCountToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :session_count, :integer
  end
end
