class FixDefaulDescriptiontForScope < ActiveRecord::Migration
  def up
  	change_column :scopes, :description, :text, :default => "", :null => false
  end

  def down
  	change_column :scopes, :description, :text, :default => nil
  end
end
