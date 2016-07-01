class CreateDevxArticleMedia < ActiveRecord::Migration
  def change
    create_table :devx_article_media do |t|
    	t.belongs_to :article
    	t.belongs_to :medium
    	t.integer :position

      t.timestamps null: false
    end
  end
end
