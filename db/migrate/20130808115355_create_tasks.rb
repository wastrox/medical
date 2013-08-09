class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :index
      t.text :description
      t.boolean :complete, :default => false

      t.timestamps
    end
  end
end
