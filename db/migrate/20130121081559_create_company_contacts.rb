class CreateCompanyContacts < ActiveRecord::Migration
  def change
    create_table :company_contacts do |t|
      t.string :name
      t.string :phone
      t.references :company

      t.timestamps
    end
    add_index :company_contacts, :company_id
  end
end
