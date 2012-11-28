class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|

      t.references :resume
			t.integer :applicant_id

      t.string :firstname
      t.string :lastname
      t.string :surename
      t.date :date
      t.string :city
      t.integer :phone
      t.text :about_me

      t.timestamps
    end
    add_index :profiles, :resume_id
		
  end
end
