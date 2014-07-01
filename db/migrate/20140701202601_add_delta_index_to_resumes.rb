class AddDeltaIndexToResumes < ActiveRecord::Migration
  def change
  	add_index :resumes, :delta
  end
end
