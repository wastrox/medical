class ChangeAdditionalInfoToTextForResume < ActiveRecord::Migration
  def up
  		change_column :resumes, :additional_info, :text
  end

  def down
  end
end
