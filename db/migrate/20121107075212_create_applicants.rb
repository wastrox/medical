class CreateApplicants < ActiveRecord::Migration
  def change
    create_table :applicants do |t|
      t.string :firstname
      t.string :lastname
      t.string :surename
      t.date :date
      t.string :city
      t.integer :phone
      t.text :about_me

      t.timestamps
    end
  end
end
