class RemoveCategoryToVacancy < ActiveRecord::Migration
  def up
    remove_column :vacancies, :category
  end

  def down
    add_column :vacancies, :category, :string
  end
end
