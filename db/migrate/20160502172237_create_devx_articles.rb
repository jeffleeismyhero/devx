class CreateDevxArticles < ActiveRecord::Migration
  def change
    create_table :devx_articles do |t|
      t.string :title
      t.string :slug
      t.string :short_description
      t.text :content
      t.string :image
      t.datetime :published_at
      t.datetime :approved_at
      t.integer :approved_by

      t.timestamps null: false
    end

    add_index :devx_articles, :published_at
  end
end
