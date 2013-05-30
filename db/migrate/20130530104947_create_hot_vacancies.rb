class CreateHotVacancies < ActiveRecord::Migration
  def change
    create_table :hot_vacancies do |t|
      t.references :vacancy
      t.string :description

      t.timestamps
    end
    add_index :hot_vacancies, :vacancy_id
  end
end
