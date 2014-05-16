class CreateMorphers < ActiveRecord::Migration
  def change
    create_table :morphers do |t|
      t.text :case

      t.timestamps
    end
  end
end
