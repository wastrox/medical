class RemoveCompanyIdToVacancy < ActiveRecord::Migration
  def up
    remove_column :vacancies, :conpany_id
  end

  def down
    add_column :vacancies, :conpany_id, :integer
  end
end
