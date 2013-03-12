class AddDeltaToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :delta, :boolean, :default => true,
    :null => false
  end
end
