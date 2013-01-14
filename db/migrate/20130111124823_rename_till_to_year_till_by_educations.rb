class RenameTillToYearTillByEducations < ActiveRecord::Migration
  def up
	rename_column :educations, :till, :year_till
  end

  def down
  end
end
