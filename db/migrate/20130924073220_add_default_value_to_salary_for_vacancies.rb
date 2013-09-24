class AddDefaultValueToSalaryForVacancies < ActiveRecord::Migration
  def up
      change_column :vacancies, :salary, :integer, :default => 0
  end

  def down
      change_column :vacancies, :salary, :integer
  end
end
