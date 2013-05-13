class CreateResumeResponds < ActiveRecord::Migration
  def change
    create_table :resume_responds do |t|
      t.references :resume
      t.references :employer
      t.date :respond_date

      t.timestamps
    end
    add_index :resume_responds, :resume_id
    add_index :resume_responds, :employer_id
  end
end
