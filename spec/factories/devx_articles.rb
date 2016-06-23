FactoryGirl.define do
  sequence :article_title do |n|
    "article-#{n}"
  end

  factory :devx_article, class: 'Devx::Article' do
    title { generate(:article_title) }
    content 'This is an article.'
    tag_list 'Example'
  end
end
