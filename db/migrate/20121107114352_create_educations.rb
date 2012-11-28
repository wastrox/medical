class CreateEducations < ActiveRecord::Migration
  def change
    create_table :educations do |t|
      t.references :resume
      t.string :college
      t.boolean :student
      t.string :profession
      t.string :diploma
      t.string :faculty
      t.date :till

      t.timestamps
    end
    add_index :educations, :resume_id
  end
end
