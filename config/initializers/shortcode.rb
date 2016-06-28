Shortcode.setup do |config|
  config.template_path = "#{Devx::Engine.root}/app/views/devx/shortcode_templates"
  config.block_tags = [ ]
  config.self_closing_tags = [
    :slideshow,
    :event_list_boxed,
    :event_list_columns,
    :media,
    :latest_articles,
    :latest_articles_columns,
    :articles_columns,
    :menu,
    :submenu,
    :extracurriculars,
    :athletics,
    :faqs,
    :twitter,
    :facebook
  ]
end

Shortcode.register_presenter(
  Devx::SlideshowPresenter,
  Devx::EventListBoxedPresenter,
  Devx::EventListColumnsPresenter,
  Devx::MediaPresenter,
  Devx::LatestArticlesPresenter,
  Devx::LatestArticlesColumnsPresenter,
  Devx::ArticlesColumnsPresenter,
  Devx::MenuPresenter,
  Devx::SubmenuPresenter,
  Devx::ExtracurricularsPresenter,
  Devx::AthleticsPresenter,
  Devx::FaqsPresenter,
  Devx::FacebookPresenter,
  Devx::TwitterPresenter
)