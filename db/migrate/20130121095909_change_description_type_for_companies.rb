class ChangeDescriptionTypeForCompanies < ActiveRecord::Migration
  def up
    change_table :companies do |t|
      t.change :description, :text
    end
  end

  def down
  end
end
