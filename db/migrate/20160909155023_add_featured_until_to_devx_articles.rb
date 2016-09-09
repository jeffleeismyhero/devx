class AddFeaturedUntilToDevxArticles < ActiveRecord::Migration
  def change
    add_column :devx_articles, :featured, :boolean, default: false
    add_column :devx_articles, :featured_until, :datetime
  end
end
