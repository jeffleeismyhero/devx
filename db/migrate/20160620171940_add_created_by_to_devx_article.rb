class AddCreatedByToDevxArticle < ActiveRecord::Migration
  def change
    add_column :devx_articles, :belongs_to, :user
  end
end
