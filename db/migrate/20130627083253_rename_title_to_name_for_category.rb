class RenameTitleToNameForCategory < ActiveRecord::Migration
  rename_column :categories, :title, :name
end
