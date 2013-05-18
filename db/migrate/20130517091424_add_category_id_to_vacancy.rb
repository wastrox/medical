class AddCategoryIdToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :category_id, :integer
  end
end
