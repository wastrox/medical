class CreateScopes < ActiveRecord::Migration
  def change
    create_table :scopes do |t|
      t.string :title

      t.timestamps
    end
  end
end
