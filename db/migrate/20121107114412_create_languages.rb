class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.references :applicant
      t.string :language
      t.integer :skill

      t.timestamps
    end
    add_index :languages, :applicant_id
  end
end
