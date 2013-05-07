class CreateVacancyResponds < ActiveRecord::Migration
  def change
    create_table :vacancy_responds do |t|
      t.references :vacancy
      t.references :applicant

      t.timestamps
    end
    add_index :vacancy_responds, :vacancy_id
    add_index :vacancy_responds, :applicant_id
  end
end
