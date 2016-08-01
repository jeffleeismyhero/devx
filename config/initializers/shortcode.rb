Shortcode.setup do |config|
  config.template_path = "#{Devx::Engine.root}/app/views/devx/shortcode_templates"
  config.block_tags = [ ]
  config.self_closing_tags = [
    :slideshow,
    :event_list_boxed,
    :event_list_columns,
    :event_list_table,
    :media,
    :latest_articles,
    :latest_articles_columns,
    :articles_columns,
    :article_category,
    :article_category_table,
    :menu,
    :submenu,
    :extracurriculars,
    :athletics,
    :faqs,
    :twitter,
    :facebook,
    :form
  ]
end

Shortcode.register_presenter(
  Devx::SlideshowPresenter,
  Devx::EventListBoxedPresenter,
  Devx::EventListColumnsPresenter,
  Devx::EventListTablePresenter,
  Devx::MediaPresenter,
  Devx::LatestArticlesPresenter,
  Devx::LatestArticlesColumnsPresenter,
  Devx::ArticlesColumnsPresenter,
  Devx::ArticleCategoryPresenter,
  Devx::ArticleCategoryTablePresenter,
  Devx::MenuPresenter,
  Devx::SubmenuPresenter,
  Devx::ExtracurricularsPresenter,
  Devx::AthleticsPresenter,
  Devx::FaqsPresenter,
  Devx::FacebookPresenter,
  Devx::TwitterPresenter,
  Devx::FormPresenter
)