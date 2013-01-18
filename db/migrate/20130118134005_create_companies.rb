class CreateCompanies < ActiveRecord::Migration
  def change
    create_table :companies do |t|
      t.string :name
      t.string :site
      t.string :scope
      t.string :description
      t.references :employer

      t.timestamps
    end
    add_index :companies, :employer_id
  end
end
