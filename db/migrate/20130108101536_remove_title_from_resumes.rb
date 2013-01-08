class RemoveTitleFromResumes < ActiveRecord::Migration
  def up
    remove_column :resumes, :title
  end

  def down
    add_column :resumes, :title, :string
  end
end
