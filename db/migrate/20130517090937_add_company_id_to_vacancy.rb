class AddCompanyIdToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :conpany_id, :integer
  end
end
