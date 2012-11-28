class CreateLanguages < ActiveRecord::Migration
  def change
    create_table :languages do |t|
      t.references :resume
      t.string :language
      t.integer :skill

      t.timestamps
    end
    add_index :languages, :resume_id
  end
end
