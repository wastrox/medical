class AddPositionAndSalaryToResumes < ActiveRecord::Migration
  def change
    add_column :resumes, :position, :string
    add_column :resumes, :salary, :string
  end
end
