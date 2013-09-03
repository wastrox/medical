class ChangeDescriptionToText < ActiveRecord::Migration
  def self.up
  		change_column :vacancies, :description, :text
  end

  def self.down
  end
end
