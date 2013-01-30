class AddTimetableOtherFromVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :timetable_other, :string
  end
end
