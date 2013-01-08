class RemoveCityFromProfiles < ActiveRecord::Migration
  def up
    remove_column :profiles, :city
  end

  def down
    add_column :profiles, :city, :string
  end
end
