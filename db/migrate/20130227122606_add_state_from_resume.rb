class AddStateFromResume < ActiveRecord::Migration
  def change
    add_column :resumes, :state, :string
  end
end
