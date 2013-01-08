class AddCityToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :city, :string
  end
end
