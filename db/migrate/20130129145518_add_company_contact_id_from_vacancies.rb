class AddCompanyContactIdFromVacancies < ActiveRecord::Migration
  def change
    add_column :vacancies, :company_contact_id, :integer
  end
end
