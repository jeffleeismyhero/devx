class AddDocumentToDevxArticles < ActiveRecord::Migration
  def change
    add_column :devx_articles, :document, :string
  end
end
