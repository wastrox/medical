class CreateExperiences < ActiveRecord::Migration
  def change
    create_table :experiences do |t|
      t.references :resume
			t.string :position
      t.string :company
      t.text :achievements
      t.date :from
      t.date :till

      t.timestamps
    end
    add_index :experiences, :resume_id
  end
end
