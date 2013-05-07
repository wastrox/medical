class AddRespondDateToVacancyRespond < ActiveRecord::Migration
  def change
    add_column :vacancy_responds, :respond_date, :date
  end
end
