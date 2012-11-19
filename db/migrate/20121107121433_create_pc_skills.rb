class CreatePcSkills < ActiveRecord::Migration
  def change
    create_table :pc_skills do |t|
      t.references :applicant
      t.string :name
      t.integer :skill

      t.timestamps
    end
    add_index :pc_skills, :applicant_id
  end
end
