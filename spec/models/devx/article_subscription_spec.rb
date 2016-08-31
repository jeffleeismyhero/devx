require 'rails_helper'

module Devx
  RSpec.describe ArticleSubscription, type: :model do
    let(:article_subscription){ FactoryGirl.create(:devx_article_subscription) }

    ## Title unit test
    describe 'user' do
      it 'should be invalid if user is blank' do
        article_subscription.user = nil
        expect(article_subscription).not_to be_valid
      end

      it 'should be invalid if user is already subscribed' do
        subscription = FactoryGirl.build(
          :devx_article_subscription,
          user: article_subscription.user,
          category: 'basketball'
        )
        expect(subscription).not_to be_valid
      end

      it 'should be valid if user is present' do
        expect(article_subscription).to be_valid
      end
    end

    describe 'category' do
      it 'should be invalid if category is blank' do
        article_subscription.category = nil
        expect(article_subscription).not_to be_valid
      end

      it 'should be valid if category is present' do
        expect(article_subscription).to be_valid
      end
    end

  end
end
