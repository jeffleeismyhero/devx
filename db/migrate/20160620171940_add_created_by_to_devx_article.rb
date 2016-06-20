class AddCreatedByToDevxArticle < ActiveRecord::Migration
  def change
    add_column :devx_articles, :user_id, :integer
  end
end
