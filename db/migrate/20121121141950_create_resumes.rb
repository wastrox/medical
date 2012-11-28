class CreateResumes < ActiveRecord::Migration
  def change
    create_table :resumes do |t|
      t.references :applicant

      t.timestamps
    end
    add_index :resumes, :applicant_id
  end
end
