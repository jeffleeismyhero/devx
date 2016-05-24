Shortcode.setup do |config|
  config.template_path = "#{Devx::Engine.root}/app/views/devx/shortcode_templates"
  config.block_tags = [ ]
  config.self_closing_tags = [
    :slideshow,
    :event_list_boxed,
    :media,
    :latest_articles,
    :menu,
    :submenu
  ]
end

Shortcode.register_presenter(
  Devx::SlideshowPresenter,
  Devx::EventListBoxedPresenter,
  Devx::MediaPresenter,
  Devx::LatestArticlesPresenter,
  Devx::MenuPresenter,
  Devx::SubmenuPresenter
)