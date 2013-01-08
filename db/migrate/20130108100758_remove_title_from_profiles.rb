class RemoveTitleFromProfiles < ActiveRecord::Migration
  def up
    remove_column :profiles, :title
  end

  def down
    add_column :profiles, :title, :string
  end
end
