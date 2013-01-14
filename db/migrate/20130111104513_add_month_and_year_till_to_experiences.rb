class AddMonthAndYearTillToExperiences < ActiveRecord::Migration
  def change
    add_column :experiences, :month_till, :string
    add_column :experiences, :year_till, :integer
  end
end
