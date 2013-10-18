class AddAttachmentCoverToScope < ActiveRecord::Migration
  def self.up
    change_table :scopes do |t|
      t.attachment :cover
    end
  end

  def self.down
    drop_attached_file :scopes, :cover
  end
end
