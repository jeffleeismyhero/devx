FactoryGirl.define do
  sequence :article_title do |n|
    "article-#{n}"
  end

  factory :devx_article, class: 'Devx::Article' do
    title { generate(:article_title) }
    content 'This is an article.'
    tag_list 'Example'
    published_at { Time.now }
    factory :devx_article_featured do
      featured true
    end
    factory :devx_article_featured_until do
      featured true
      featured_until { Time.now + 1.week }
    end
  end
end
