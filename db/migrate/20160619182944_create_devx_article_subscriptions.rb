class CreateDevxArticleSubscriptions < ActiveRecord::Migration
  def change
    create_table :devx_article_subscriptions do |t|
      t.string :category
      t.belongs_to :user

      t.timestamps null: false
    end
  end
end
