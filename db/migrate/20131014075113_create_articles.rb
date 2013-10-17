class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.string :title
      t.string :description
      t.text :body
      t.datetime :published_at
      t.string :state
      t.attachment :cover

      t.timestamps
    end
  end
end
