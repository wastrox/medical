class AddMonthAndYearFromToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :month_from, :string
    add_column :experiences, :year_from, :integer
  end
end
