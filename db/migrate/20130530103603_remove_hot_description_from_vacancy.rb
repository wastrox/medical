class RemoveHotDescriptionFromVacancy < ActiveRecord::Migration
  def up
    remove_column :vacancies, :hot_description
  end

  def down
    add_column :vacancies, :hot_description, :string
  end
end
