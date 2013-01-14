class AddCurrentWorkplaceToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :current_workplace, :boolean
  end
end
