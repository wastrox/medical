class AddDeltaIndexToVacancies < ActiveRecord::Migration
  def change
  	add_index :vacancies, :delta
  end
end
