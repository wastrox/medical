class AddDeltaToVacancy < ActiveRecord::Migration
  def change
    add_column :vacancies, :delta, :boolean, :default => true,
    :null => false
  end
end
