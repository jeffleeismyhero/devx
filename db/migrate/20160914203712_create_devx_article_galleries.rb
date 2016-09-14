class CreateDevxArticleGalleries < ActiveRecord::Migration
  def change
    create_table :devx_article_galleries do |t|
      t.belongs_to :article
      t.string :file
      t.integer :position

      t.timestamps null: false
    end
  end
end
