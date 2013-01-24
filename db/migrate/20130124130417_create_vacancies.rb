class CreateVacancies < ActiveRecord::Migration
  def change
    create_table :vacancies do |t|
      t.references :company
      t.string :name
      t.string :category
      t.string :city
      t.integer :salary
      t.string :experiences
      t.string :timetable
      t.string :description

      t.timestamps
    end
    add_index :vacancies, :company_id
  end
end
