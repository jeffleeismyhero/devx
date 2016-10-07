require 'rails_helper'

module Devx
  RSpec.describe Article, type: :model do
    let(:article){ FactoryGirl.create(:devx_article) }

    ## Title unit test
    describe 'title' do
      it 'should be invalid if title is blank' do
        article.title = ''
        expect(article).not_to be_valid
      end
    end

    describe 'content' do
      it 'should be invalid if content is blank' do
        article.content = ''
        expect(article).not_to be_valid
      end
    end

    describe 'featured content' do
      it 'should be ordered' do
        Devx::Article.destroy_all
        article1 = FactoryGirl.build(:devx_article_featured)
        article2 = FactoryGirl.build(:devx_article_featured_until)
        article3 = FactoryGirl.build(:devx_article_featured_until, featured_until: Time.now - 1.day)
        article4 = FactoryGirl.build(:devx_article_featured)
        article5 = FactoryGirl.build(:devx_article)
        article6 = FactoryGirl.build(:devx_article)
        expect {
          article1.save
          article2.save
          article3.save
          article4.save
          article5.save
          article6.save
        }.to change(Devx::Article.featured, :count).by(5)

        featured_articles = Devx::Article.featured
        expect(featured_articles).not_to include(article3)
        expect(featured_articles).to eq([article2, article4, article1, article6, article5])
      end
    end

    describe 'article galleries' do
      it 'should allow multiple article gallery images' do
        article = FactoryGirl.build(:devx_article)
        expect(article).to respond_to(:article_galleries)
      end
    end
  end
end
