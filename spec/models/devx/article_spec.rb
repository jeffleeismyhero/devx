require 'rails_helper'

module Devx
  RSpec.describe Article, type: :model do
    let(:article){ FactoryGirl.build(:devx_article) }

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

  end
end
