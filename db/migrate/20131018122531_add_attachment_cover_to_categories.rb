class AddAttachmentCoverToCategories < ActiveRecord::Migration
  def self.up
    change_table :categories do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :categories, :cover
  end
end
