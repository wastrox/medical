class CreatePcSkills < ActiveRecord::Migration
  def change
    create_table :pc_skills do |t|
      t.references :resume
      t.string :name
      t.integer :skill

      t.timestamps
    end
    add_index :pc_skills, :resume_id
  end
end
