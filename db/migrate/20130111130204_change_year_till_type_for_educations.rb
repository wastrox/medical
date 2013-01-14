class ChangeYearTillTypeForEducations < ActiveRecord::Migration
  def up
    change_table :educations do |t|
      t.change :year_till, :integer
    end
  end

  def down
  end
end
