class AddSessionLastTimeToAccount < ActiveRecord::Migration
  def change
    add_column :accounts, :session_last_time, :datetime, :default => 0
  end
end
