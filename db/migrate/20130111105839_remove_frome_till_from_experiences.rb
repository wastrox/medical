class RemoveFromeTillFromExperiences < ActiveRecord::Migration
  def up
    remove_column :experiences, :from
    remove_column :experiences, :till
  end

  def down
    add_column :experiences, :till, :date
    add_column :experiences, :from, :date
  end
end
