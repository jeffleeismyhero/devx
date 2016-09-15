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
        }.to change(Devx::Article.featured, :count).by(3)

        featured_articles = Devx::Article.featured
        expect(featured_articles).not_to include([article3, article5, article6])
        expect(featured_articles).to eq([article2, article4, article1])
      end

      it 'should not be displayed if featured is false' do
        Devx::Article.destroy_all
        article1 = FactoryGirl.build(:devx_article_featured)
        article2 = FactoryGirl.build(:devx_article_featured_until, featured: false)
        expect {
          article1.save
          article2.save
        }.to change(Devx::Article.featured, :count).by(1)
      end
    end
  end
end
