class AddDefaultValueToSalaryForResumes < ActiveRecord::Migration
	def up
	    change_column :resumes, :salary, :integer, :default => 0
	end

	def down
	    change_column :resumes, :salary, :integer
	end
end
