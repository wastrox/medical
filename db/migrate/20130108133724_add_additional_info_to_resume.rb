class AddAdditionalInfoToResume < ActiveRecord::Migration
  def change
    add_column :resumes, :additional_info, :string
  end
end
