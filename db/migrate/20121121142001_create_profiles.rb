class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.references :resume
			t.integer :applicant_id
      t.string :title
      t.string :firstname
      t.string :lastname
      t.string :surename
      t.date   :date
      t.string :city
      t.string :phone

      t.timestamps
    end
    add_index :profiles, :resume_id
		
  end
end
