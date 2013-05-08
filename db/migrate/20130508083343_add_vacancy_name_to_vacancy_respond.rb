class AddVacancyNameToVacancyRespond < ActiveRecord::Migration
  def change
    add_column :vacancy_responds, :vacancy_name, :string
  end
end
