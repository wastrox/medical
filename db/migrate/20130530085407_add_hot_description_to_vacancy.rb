class AddHotDescriptionToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :hot_description, :string
  end
end
