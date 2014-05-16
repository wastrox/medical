class AddMorpherIdToCities < ActiveRecord::Migration
  def change
    add_column :cities, :morpher_id, :integer
  end
end
