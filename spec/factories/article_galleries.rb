FactoryGirl.define do
  sequence :article_gallery_filename do |n|
    "image-#{n}.jpg"
  end

  factory :devx_article_gallery, class: 'Devx::ArticleGallery' do
    file { generate(:article_gallery_filename) }
  end
end
